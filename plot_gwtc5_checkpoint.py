#!/usr/bin/env python3
import argparse, json
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

RUN_COLORS={'O1':'#dbeafe','O2':'#e0e7ff','O3a':'#ede9fe','O3b':'#fae8ff','O4a':'#fee2e2','O4b':'#ffedd5'}
POINT_COLORS={'O1':'#2563eb','O2':'#4f46e5','O3a':'#7c3aed','O3b':'#c026d3','O4a':'#dc2626','O4b':'#ea580c'}

def main():
 p=argparse.ArgumentParser(); p.add_argument('audit',type=Path); p.add_argument('--output',type=Path,default=Path('gwtc5_fixed_point_checkpoint.png')); args=p.parse_args()
 d=json.loads(args.audit.read_text()); terms=d['attribution']['event_terms']; n=len(terms)
 vals=np.array([x['delta_log_event_term_pdt_minus_gr'] for x in terms]); dist=np.array([x['median_luminosity_distance_mpc']/1000 for x in terms]); runs=[x['run'] for x in terms]
 per=d['attribution']['selection_term_per_event']; x=np.arange(1,n+1)
 ce=np.cumsum(vals); cs=per*x; ct=ce+cs
 fig,(ax,sc)=plt.subplots(1,2,figsize=(13.5,6.2),gridspec_kw={'width_ratios':[1.45,1]})
 fig.subplots_adjust(left=.07,right=.985,bottom=.13,top=.82,wspace=.14)
 # Contiguous observing-run bands.
 start=0
 for i in range(1,n+1):
  if i==n or runs[i]!=runs[start]:
   end=i if i==n else i
   ax.axvspan(start+.5,end+.5,color=RUN_COLORS[runs[start]],alpha=.55,zorder=0)
   width=end-start
   ax.text((start+end+1)/2,.975,runs[start],transform=ax.get_xaxis_transform(),ha='center',va='top',fontsize=8 if width < 10 else 9,color='#374151',rotation=90 if width < 10 else 0)
   start=i
 ax.axhline(0,color='#111827',lw=.9)
 ax.plot(x,ce,color='#b91c1c',lw=2.2,label='Observed-event terms')
 ax.plot(x,cs,color='#2563eb',lw=2.2,label='Selection correction')
 ax.plot(x,ct,color='#111827',lw=2.8,label='Net fixed-point diagnostic')
 candidates=[h['events'] for h in d.get('checkpoint_history',[]) if 10 <= h['events'] <= n]
 marks=[]
 for k in candidates:
  if not marks or k-marks[-1] >= 15:
   marks.append(k)
 if n not in marks:
  marks.append(n)
 for k in marks:
  ax.scatter(k,ct[k-1],s=34,color='#111827',zorder=5)
  ax.annotate(f'{ct[k-1]:+.2f}',(k,ct[k-1]),xytext=(3,7),textcoords='offset points',fontsize=8,color='#111827')
 ax.set(xlabel='Catalog events included',ylabel=r'Cumulative $\Delta\log L$ (PDT $-$ GR)',title='Catalog accumulation')
 ax.legend(loc='lower left',frameon=True,framealpha=.95,fontsize=9)
 ax.grid(axis='y',alpha=.2)
 # Per-event distance relation.
 for run in dict.fromkeys(runs):
  m=np.array([r==run for r in runs]); sc.scatter(dist[m],vals[m],s=22,alpha=.72,color=POINT_COLORS[run],edgecolors='none',label=run)
 sc.axhline(-per,color='#111827',ls='--',lw=1.4,label=f'Per-event break-even ({-per:.3f})')
 coef=np.polyfit(dist,vals,1); xx=np.linspace(0,max(dist)*1.03,100); sc.plot(xx,np.polyval(coef,xx),color='#111827',lw=1.5,alpha=.8)
 r=d['attribution']['distance_event_term_pearson_r']
 sc.text(.96,.96,f'Pearson r = {r:.3f}\n{sum(vals<0)} / {n} event terms < 0',transform=sc.transAxes,ha='right',va='top',fontsize=10,bbox={'facecolor':'white','edgecolor':'#d1d5db','alpha':.9,'boxstyle':'round,pad=.4'})
 sc.set(xlabel='Median luminosity distance (Gpc)',ylabel=r'Per-event $\Delta\log L$ (PDT $-$ GR)',title='Distance dependence')
 sc.grid(alpha=.2); sc.legend(loc='lower left',fontsize=8,ncol=2,framealpha=.95)
 expected=d.get('input_coverage',{}).get('expected','?')
 fig.suptitle(f'GWTC-5 quartic-propagation checkpoint: {n} of {expected} events',fontsize=16,fontweight='bold',y=.975)
 fig.text(.5,.895,'Fixed population and cosmology nuisance medians; diagnostic only, not a Bayes factor or model evidence.',ha='center',fontsize=9,color='#4b5563')
 args.output.parent.mkdir(parents=True,exist_ok=True); fig.savefig(args.output,dpi=200,facecolor='white'); print(args.output)
if __name__=='__main__': main()

# Epi-Gala



## Topics 
 
### Epi toolkits
 
| Topic  | Relevant chapters | Supp. readings | Colab demos |  Key terms / R functions |
| -- |  -- |-- | -- |-- |
| Describing trends & variations in data | Jekel:9 | ["Too many digits"](https://adc.bmj.com/content/100/7/608) | | ```mean()```, ```sd()```, ```median()```, ```IQR()```; ```stem()```; ```hist()```|
||
| Bivariate regression & correlation |  Bland:11; Jekel:11 | | [Bivariate regression vs correlation](https://github.com/lisatwyw/epi-galla/blob/main/1st_bivariate_regression.ipynb) | ```data.frame```; ```t()```; ```matrix()```|
| Sample size; Type I & II errors | Jekel:12  | |
||
| Linear regression | Bland:15 (multiple regression) | | [Simulate funnel plot, LR recapped](https://github.com/lisatwyw/epi-galla/blob/main/LR_recap.ipynb) | |
| GLM | Jekel:13 |
| Logistic regression | Bland:15.10 | [Harris’ primer](https://fmch.bmj.com/content/fmch/9/Suppl_1/e001290.full.pdf) | |<ul><li>QQ</li>VIF<li></li><li>logit</li></ul> |
||
| Frequency measures| Jekel:2; [Szklo:2](http://proxy.lib.sfu.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=nlebk&AN=1229435&site=ehost-live&ebv=EB&ppid=pp_49); Szklo:3 | 
| Probability; PDFs | Jekel:7-8; Bland:6 | | [Distributions](https://github.com/lisatwyw/epi-galla.github.io/blob/main/Distributions.ipynb) |
| Bayesian approach  | Bland:22 | | | P(D;T)∝P(T;D)xP(D) |
| Hypothesis testing | Jekel:10-11; ["Analysis of cross-tabulations" Bland:13](https://canvas.sfu.ca/files/20339652/) | [Chi-square test of independence](https://www.cbsd.org/cms/lib010/PA01916442/Centricity/Domain/1912/10.1%20B%20Chi-Square%20test%20of%20independence.pdf) |  | Confidence interval; standard error; variance | 
||
| Clinical Epi | Jekel:7-8; Bland:20.6 |  
| Survival data analysis w/ CPH| Bland:16.3 (logrank test) | [R package ```survivalmodels```](https://raphaels1.github.io/survivalmodels/index.html) | [CPH](https://github.com/lisatwyw/epi-galla/blob/main/CPH_stanford2.ipynb) |  ```survfit()``` |

##  Study designs 

| Topic  | Relevant chapters | Supp. readings | Colab demos |  Key terms / R functions |
| -- |  -- |-- | -- |-- |
| Experimental | Bland:2; Jekel:4,12-13 | [Series #11: Data Analysis of Epidemiological Studies](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2853157/pdf/Dtsch_Arztebl_Int-107-0187.pdf) | |  Review on applications of <ul><li>poisson regression </li><li>logistic regresssion</li><li>relative risk (vs difference), prevalence, cumulative incidence estimate</li><li>effect modifications</li></ul> |
| Observational| Bland:3; [Szklo:1](http://proxy.lib.sfu.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=nlebk&AN=1229435&site=ehost-live&ebv=EB&ppid=pp_3); Jekel:5  | [Series #11](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2853157/pdf/Dtsch_Arztebl_Int-107-0187.pdf) | | Nested case-control; RCT ```sample()```|
| Cross-over | | [Series #18 Crossover](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3345345/pdf/Dtsch_Arztebl_Int-109-0276.pdf) | |
| Biases | Jekel:4 | |

## Advanced topics
 
| Topic  | Relevant chapters | Supp. readings | Colab demos |  Key terms |
| -- |  -- |-- | -- |-- |
| Replication | | [Harris et al. "Reproducibility of 6 Published Studies in Public Health Services and Systems Research"](https://journals.lww.com/jphmp/Abstract/2019/03000/Examining_the_Reproducibility_of_6_Published.6.aspx) |
| Reproducibility | [Szklo:9](http://proxy.lib.sfu.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=nlebk&AN=1229435&site=ehost-live&ebv=EB&ppid=pp_411) | [Coding style guide](https://google.github.io/styleguide/Rguide.html); [Writing functions to prevent errors](https://bookdown.org/medepi/phds/programming-and-r-functions.html#writing-r-functions) | [```for```loop](https://colab.research.google.com/drive/1YFrdQoDtLMLczXt0PHXKwHEFDa8Ee4rV?authuser=1#scrollTo=2_for_loop_quick_dive) |
| Maximum likelihood | Bland:22.7 | Likelihood; AIC; BIC; ```source()``` |
| Predictive models | | | [LDA/ Bone mineral density](https://github.com/lisatwyw/epi-galla/blob/main/LDA_predictions_BoneMineralDensity.ipynb) | | 


## R: importing function definitions
```
source('https://raw.githubusercontent.com/cran/car/master/R/durbinWatsonTest.R');
durbinWatsonTest( fit2 )

source('https://raw.githubusercontent.com/cran/AICcmodavg/master/R/useBIC.R');
message( 'BIC of fit1: ', useBIC( fit1 ) )

source('https://raw.githubusercontent.com/cran/car/master/R/ncvTest.R' ); 
ncvTest( fit2)
```

### ```epi.2by2```
```
source('https://raw.githubusercontent.com/cran/epiR/master/R/epi.2by2.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zexact.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zincrate.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zRRwald.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zRRtaylor.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zRRscore.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zORwald.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zORscore.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zlimit.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zORml.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zARwald.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zARscore.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zz2stat.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zlimit.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zMHRD.Sato.R')
source('https://raw.githubusercontent.com/cran/epiR/master/R/zMHRD.GR.R')

epi.2by2( c(13,2163,5,3349) )
```


### ```riskratio.wald```
```
if (0 & (!exists('riskratio')) )
{
  install.packages("epitools")
  library( epitools )  
  
} else
{
  source( 'https://raw.githubusercontent.com/cran/epitools/master/R/ormidp.test.R' )
  source( 'https://raw.githubusercontent.com/cran/epitools/master/R/tab2by2.test.R' )
  source('https://raw.githubusercontent.com/cran/epitools/master/R/table.margins.R' )
  source( 'https://raw.githubusercontent.com/cran/epitools/master/R/riskratio.wald.R' )
  source( 'https://raw.githubusercontent.com/cran/epitools/master/R/epitable.R' )

  riskratio.wald( matrix( c(11,23,11,22), 2) )
}

```

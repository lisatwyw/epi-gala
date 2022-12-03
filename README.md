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
| Logistic regression | Bland:15.10 | [Harris’ primer](https://fmch.bmj.com/content/fmch/9/Suppl_1/e001290.full.pdf) | | |
||
| Frequency measures| Jekel:2; [Szklo:2](http://proxy.lib.sfu.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=nlebk&AN=1229435&site=ehost-live&ebv=EB&ppid=pp_49); Szklo:3 | 
| Probability; PDFs | Jekel:7-8; Bland:6 | | [Distributions](https://github.com/lisatwyw/epi-galla.github.io/blob/main/Distributions.ipynb) |
| Bayesian approach  | Bland:22 | | | P(D;T)∝P(T;D)xP(D) |
| Hypothesis testing | Jekel:10-11; ["Analysis of cross-tabulations" Bland:13](https://canvas.sfu.ca/files/20339652/) | [Chi-square test of independence](https://www.cbsd.org/cms/lib010/PA01916442/Centricity/Domain/1912/10.1%20B%20Chi-Square%20test%20of%20independence.pdf) |  | Confidence interval; standard error; variance | 
||
| Clinical Epi | Jekel:7-8; Bland:20.6 |  
| Survival data analysis w/ CPH| Bland:16.3 (logrank test) | | [CPH](https://github.com/lisatwyw/epi-galla/blob/main/CPH_stanford2.ipynb) |  ```survfit()``` |

##  Study designs 

| Topic  | Relevant chapters | Supp. readings | Colab demos |  Key terms / R functions |
| -- |  -- |-- | -- |-- |
| Experimental | Bland:2; Jekel:4,12-13 | |
| Observational| Bland:3; [Szklo:1](http://proxy.lib.sfu.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=nlebk&AN=1229435&site=ehost-live&ebv=EB&ppid=pp_3); Jekel:5  | [Series #10](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2853157/pdf/Dtsch_Arztebl_Int-107-0187.pdf) | | Nested case-control; RCT (```samp```)|
| Cross-over | | [Series #18](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3345345/pdf/Dtsch_Arztebl_Int-109-0276.pdf) | |
| Biases | Jekel:4 | |

## Advanced topics
 
| Topic  | Relevant chapters | Supp. readings | Colab demos |  Key terms |
| -- |  -- |-- | -- |-- |
| Reproducibility | [Szklo:9](http://proxy.lib.sfu.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=nlebk&AN=1229435&site=ehost-live&ebv=EB&ppid=pp_411) | [Coding style guide](https://google.github.io/styleguide/Rguide.html) [Writing functions to prevent errors](https://bookdown.org/medepi/phds/programming-and-r-functions.html#writing-r-functions) | [```for```loop](https://colab.research.google.com/drive/1YFrdQoDtLMLczXt0PHXKwHEFDa8Ee4rV?authuser=1#scrollTo=2_for_loop_quick_dive) |
| Maximum likelihood | Bland:22.7 | Likelihood; AIC; BIC; ```source()``` |
| Predictive models | | | [LDA/ Bone mineral density](https://github.com/lisatwyw/epi-galla/blob/main/LDA_predictions_BoneMineralDensity.ipynb) | | 


## R: importing function definitions

source('https://raw.githubusercontent.com/cran/car/master/R/durbinWatsonTest.R');
durbinWatsonTest( fit2 )

source('https://raw.githubusercontent.com/cran/AICcmodavg/master/R/useBIC.R');
message( 'BIC of fit1: ', useBIC( fit1 ) )

source('https://raw.githubusercontent.com/cran/car/master/R/ncvTest.R' ); 
ncvTest( fit2)



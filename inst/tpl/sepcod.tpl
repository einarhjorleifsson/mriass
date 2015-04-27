DATA_SECTION

  int debug_input_flag
  !! debug_input_flag=1;
  !! ofstream ofs("input.log");
  init_adstring catchfilename;
  !! ofs << "catchfilename " << catchfilename << endl;  
  init_adstring catchresidualfilename;
  !! ofs << "catchresidualfilename " << catchresidualfilename << endl;  



  init_int firstyear    // firstyear used in the assesment
  init_int lastoptyear;    // Last year used in the assessment 
  init_int nsimuyears     // Number of years simulated
  init_int lastdatayear;  // Last year with catch in numbers data.  

  init_int firstage     // First age
  init_int lastage        // Last age
  init_int firstcatchage  // First age group in catch
//  init_int firstagewithconstantF; // Above this F is independed of age
  init_int plusgroup 	  // 1 if plus group else 0

  init_int recrdatadelay  // delay from when a yearclass is born until first data on it is available
			  // survey in assessment year that includes age 1 means a datadelay of 0 year.   

  !! ofs << "firstyear " << firstyear << "lastoptyear " << lastoptyear << "nsimuyears " << nsimuyears; 
  !! ofs << "lastdatayear " << lastdatayear  << endl;
  
  int noptyears;
  int nyears;  // number of years used in the optimiztion
  int lastyear 
  int nages;
  !!lastyear = lastoptyear  + nsimuyears;
  !!noptyears = lastoptyear - firstyear + 1; 
  !!nyears = noptyears + nsimuyears;

  !! ofs  << " firstage " << firstage << "lastage " << lastage << "firstcatchage " << firstcatchage << " plusgroup " << plusgroup;
  !! ofs << " recrdatadelay " << recrdatadelay << endl;
  !!nages = lastage - firstage + 1;


  init_adstring stockparametersfilename;
  !! ofs << "stockparametersfilename " << stockparametersfilename << endl;  
  init_adstring catchparametersfilename;
  !! ofs << "catchparametersfilename " << catchparametersfilename << endl;  
  init_adstring likelihoodparametersfilename;
  !! ofs << "likelihoodparametersfilename " << likelihoodparametersfilename << endl;  
  init_adstring outputparametersfilename;
  !! ofs << "outputparametersfilename " << outputparametersfilename << endl;  

  


  init_int nsurveys; // Number of surveys
  !! ofs << "nsurveys" << nsurveys << endl;

  ivector surveyfirstyear(1,nsurveys);
  ivector surveylastyear(1,nsurveys);
  ivector surveyfirstage(1,nsurveys);
  ivector surveylastage(1,nsurveys);
  ivector surveyfirstagewithconstantcatchability(1,nsurveys);
  ivector surveyfirstagewithfullcatchability(1,nsurveys);
  ivector surveytimefromlastyear(1,nsurveys);
  ivector surveytype(1,nsurveys);
  ivector surveyweightsgiven(1,nsurveys);

 // Now we come to a little tricky part where the input in AD-model builder is rather 
// limiting.  Have to read from *global_datafile  Three datafiles for each survey.  
  !!int i,j;
  !!ivector tmpsurveydata(1,8);
  !!adstring tmpsurveyfilename;  // Have to pass this to main program through file.  
  !!ofstream surveyfile("SURVEYFILES.DAT"); // The temporary file.  
  !!for (i = 1; i<=nsurveys; i++) {
     !!*global_datafile  >> tmpsurveydata;
     !! ofs << "survey nr" << i << " - " << tmpsurveydata << "  ";
     !! surveyfirstyear(i) = tmpsurveydata(1);
     !! surveylastyear(i) = tmpsurveydata(2);
     !! surveyfirstage(i) = tmpsurveydata(3);
     !! surveylastage(i) = tmpsurveydata(4);
     !! surveyfirstagewithfullcatchability(i) = tmpsurveydata(5);
     !! surveyfirstagewithconstantcatchability(i) = tmpsurveydata(6);
     !! surveytimefromlastyear(i) = tmpsurveydata(7);
     !! surveytype(i) = tmpsurveydata(8);
     !! if(surveyfirstyear(i) < firstyear) surveyfirstyear(i) = firstyear;
     !! if(surveylastyear(i) > lastyear+ surveytimefromlastyear(i)) 
     !!    surveylastyear(i) =  lastyear+ surveytimefromlastyear(i);
     !! if(surveyfirstage(i)  < firstage) surveyfirstage(i) = firstage;
     !! if(surveylastage(i) > lastage) surveylastage(i) = lastage;
     !! if(surveyfirstagewithconstantcatchability(i) > lastage )
     !!      surveyfirstagewithconstantcatchability(i) = lastage;
     !! for (j = 1; j <= 3; j++) {
       !!*global_datafile  >> tmpsurveyfilename;
       !! ofs << tmpsurveyfilename << " "; 
       !! surveyfile << tmpsurveyfilename << " ";
     !! }
     !! surveyfile << endl;
     !! ofs << endl; 
   !!}
   !!surveyfile.close();
   int minsurveyfirstage
   int maxsurveyfirstagewithfullcatchability;
   int maxsurveyfirstagewithconstantcatchability;
   !! minsurveyfirstage = min(surveyfirstage);
   !! maxsurveyfirstagewithfullcatchability = max(surveyfirstagewithfullcatchability);
   !! maxsurveyfirstagewithconstantcatchability = max(surveyfirstagewithconstantcatchability);


   int COUNTER;  // For random number generation

//************************************************************************************************
// Parameters for stock recruitment relationship PropofFbeforeSpawning and 
// init_number PropofMbeforeSpawning should possibly be made agedependent ????
// These parameters are input here as it is decided which parameters are to be estimated.  

  init_int SSBRectype   // if 1 Beverton and Holt, 2  Ricker 6 constant
// Parameters in SSBRecr function  1.  SSBmax   2. Rmax 3.  CV  4.  Correlation 
// 5.  Power for CV as function of ssb
// 6 Timetrendinrecruitment  7.  RefSSB  8.  Minrelssb  9.  Maxrelssb:   
  init_vector SSBRecParameters(1,6);
  init_vector SSBRecSwitches(1,6)  // Phase of  6 first of SSBRecParameters.  -1 not estimated. 

  !!ofs << "SSBRectype " << SSBRectype << endl;
  !!ofs  << " Rmax " << SSBRecParameters(1) << " SSBmax " << SSBRecParameters(2) ; 
  !!ofs << " SSBReccv " << SSBRecParameters(3)  ;
  !!ofs << " SSBReccorr " <<  SSBRecParameters(4) << " SSBRecpow" << SSBRecParameters(5)  << endl;
  !!ofs << " Timetrendinrecruitment" <<  SSBRecParameters(6) << endl;

  !!ofs << " SSBRecSwitches " << SSBRecSwitches << endl;
 
 
//***********************************************************************************************
//Number of Migration events has to be input here as the number of events is dependent on them.  
//The exact years and ages are in read with stock parameters.  
  init_int MigrationNumbers;
  !! ofs << "MigrationNumbers " << MigrationNumbers << endl ;



//**************************************************************************************
// Data regarding output  

//***********************************************************************************+++
// Prognosis  
// CatchRule 1 Specified catch, 2 Specified F trigger,  Proportion of biomass
// PrognosisFile contains information on maturity, weight at age etc but 
// later rest of the prognosisdata might be input from file.  

  init_adstring PrognosisFilename;
  !! ofs << "PrognosisFilename " << PrognosisFilename  << endl;
  init_adstring WeightAndMaturityDatafilename;     
  !!ofs << "WeightAndMaturityDatafilename" <<  WeightAndMaturityDatafilename << endl;   
  init_int  number_of_seperable_periods;
  !!ofs <<  "number_of_seperable_periods " <<  number_of_seperable_periods << endl;
// Prognosisvariables
//  init_int  parametersfromfile // If a file is used to give the parameter values -ainp
//  !!ofs <<   "parametersfromfile " << parametersfromfile << endl;

  number CatchRule;  // 1 specified catch, 2 Frule trigger, 3 HCR evaluated, 4 Frule no trigger, 
  // 5 harvest ratio changed with size.   Only rules 1, 2 and 3 need to be looked at.  
  number weightcv;
  number weightcorr;
  number Assessmentcv;
  number Assessmentcorr;
  number CurrentAssessmentErrmultiplier;
  number Recrcorr; 
  number UseStockWeights;
  number  HCRrefage;
  number Btrigger;
  number RatioCurrentTac;
  number RatioCurrentTacUnchangedBelowBtrigger;
  number EstimatedAssYearRefBio;  // Estimate from current ass, added 18 feb 2013
  int nprogselyears;
  int nweightandmaturityselyears;  
  number HarvestRatio;
  number HarvestRatio1;   // okt 2012 harvest ratio function of ssbsize
  number HarvestRatio2;  // okt 2012 harvest ratio function of ssbsize
  number PrintAll;  // okt 2012 print all not possible yet
  number Refbiobreak1; // okt 2012 harvest ratio function of ssbsize
  number Refbiobreak2; // okt 2012 harvest ratio function of ssbsize


  number CurrentTacInput;
  number TacLeftInput;
  number CurrentStockScaler; 


  vector FutureForCatch(lastoptyear+1,lastyear); // Catch or Ffor the next years


  int Frefage1;
  int Frefage2; 
  int WeightedF;
  ivector MigrationAges(1,MigrationNumbers);
  ivector MigrationYears(1,MigrationNumbers);
  int minssbage;
  int CatchRobust;
  int SurveyRobust;
  int Nbasfunc; 
  !! Nbasfunc = 4; 

  int likelihood_mcmc_lines;
  int migration_mcmc_lines;
  int recruitment_mcmc_lines;
  int initpopulation_mcmc_lines;
  int assessmentyearpopulation_mcmc_lines;
  int estimatedselection_mcmc_lines;
  int parameter_mcmc_lines;
  int surveypower_mcmc_lines;
  int surveyq_mcmc_lines;
  int effort_mcmc_lines;
  int catch_mcmc_lines;
  int assessmenterror_mcmc_lines;

  int refbio_mcmc_lines;
  int refbiohcrwitherr_mcmc_lines;
  int ssbwitherr_mcmc_lines;
  int fishingyeartac_mcmc_lines;

  int n3_mcmc_lines;
  int f_mcmc_lines;
  int ssb_mcmc_lines;
  int relssb_mcmc_lines;
  int refbiohcr_mcmc_lines;
  int finalpopulation_mcmc_lines;
  int swt6_mcmc_lines;
  int ssbrec_mcmc_lines;
  int swt3_mcmc_lines;
  int cbior_mcmc_lines;


  int mcmc_iteration;
  ivector parcolnr(firstyear,lastyear);  // column in parameter vector.  


PARAMETER_SECTION

// Estimated variables;

 init_bounded_number  logChangeInQage1MarchSince2003(-1,1,3); // Special for March survey age 1 in Icelandic cod.  
 init_bounded_vector lnMigrationAbundance(1,MigrationNumbers,1,13);
 init_bounded_number lnMeanRecr(5,18);
 init_bounded_dev_vector lnRecr(firstyear,lastoptyear+firstage-recrdatadelay,-6,6,3) ;// log of recruitment
 init_bounded_number lnMeanInitialpop(4,14,3);
 init_bounded_dev_vector lnInitialpop(firstage+1,lastage,-7,7);
// init_bounded_dev_vector InitialSelection(firstcatchage,lastage-2,-4,4,2); // Same selction of last 3 age groups
 vector  InitialSelection(firstcatchage,lastage-3);
// 0.2 to allow only 20  over.  
 init_bounded_matrix EstimatedSelection(firstcatchage,lastage-4,1,number_of_seperable_periods,-4,0.2,2); // Same selction of last 3 age groups
 init_bounded_number Catchlogitslope(0.01,5,2);
 init_bounded_number Catchlogitage50(1,11,2);
 init_bounded_number logSigmaCmultiplier(-1,1,4);
 init_bounded_vector Surveycorr(1,nsurveys,0.2,0.85,4);
//   number Surveycorr;
  init_bounded_number AbundanceMultiplier(-10,10,6);


  init_bounded_matrix SurveyPowerest(1,nsurveys,minsurveyfirstage,maxsurveyfirstagewithconstantcatchability,1,3,4);
//  matrix  SurveyPowerest(1,nsurveys,minsurveyfirstage,maxsurveyfirstagewithconstantcatchability);
  init_bounded_vector SigmaSurveypar(1,nsurveys,-5,3,5);
//  vector SigmaSurveypar(1,nsurveys);
  init_bounded_matrix SurveylnQest(1,nsurveys,minsurveyfirstage,maxsurveyfirstagewithfullcatchability,-40,-3,4);

  vector Surveylikelihood(1,nsurveys);
  init_bounded_number lnMeanEffort(-3,3);
  init_bounded_dev_vector lnEffort(firstyear,lastoptyear,-4,4,2);  // log of Fishing mortality of oldest fish i.e effor
//  init_bounded_matrix Fpar(firstyear,lastoptyear,1,Nbasfunc,-10,1.5,3);
  matrix Fpar(firstyear,lastoptyear,1,Nbasfunc);
  


// Parameters in SSB-recruitment.  
  !!dvector srlb(1,6);
  !!dvector srub(1,6);
  !!ivector srphase(1,6);
//srlb(2) is set to 3.68 ie. log 40 as lower bound on ssbbreak.  another option 
//would be to estimate ssbbreak directly.  
  !!srlb(1)=4.0 ; srlb(2)=4.78 ; srlb(3)=-1.3 ; srlb(4)=-4.6 ; srlb(5)=-1.0 ; srlb(6)=-1.0;  // -0.2
//  !!srub(1)=18.0 ; srub(2)=10.0 ; srub(3)=1.0 ; srub(4)=-0.1 ; srub(5)=1.0 ; srub(6)=1.0;//0.2
  !!srub(1)=18.0 ; srub(2)=6.9 ; srub(3)=1.0 ; srub(4)=-0.02 ; srub(5)=1.0 ; srub(6)=1.0;//change Jan 2013
  !!srphase = ivector(SSBRecSwitches);
  init_bounded_number_vector estSSBRecParameters(1,6,srlb,srub,srphase);



  number firsttime; // for printing

// -1 is missing value.  
  matrix ObsCatchInNumbers(firstyear,lastyear,firstage,lastage);
  matrix CatchDiff(firstyear,lastyear,firstage,lastage);

// Data are the original variables read from files.  
  matrix CatchWeightsData(firstyear,lastyear,firstage,lastage);
  matrix StockWeightsData(firstyear,lastyear,firstage,lastage);
  matrix SSBWeightsData(firstyear,lastyear,firstage,lastage) ;
  matrix StockMaturityData(firstyear,lastyear,firstage,lastage);

// This set is the same as before but for stochastic simulations 
  matrix CatchWeights(firstyear,lastyear,firstage,lastage);
  matrix StockWeights(firstyear,lastyear,firstage,lastage);
  matrix SSBWeights(firstyear,lastyear,firstage,lastage) ;
  matrix StockMaturity(firstyear,lastyear,firstage,lastage);


  matrix N(firstyear,lastyear,firstage,lastage)
  matrix F(firstyear,lastyear,firstage,lastage)
  matrix natM(firstyear,lastyear,firstage,lastage)   // Natural mortality 
  matrix Z(firstyear,lastyear,firstage,lastage);  // Total mortality
  matrix PropInCatch(firstyear,lastyear,firstage,lastage); // Modelled proportion in catch
  vector TotalCalcCatchInNumbers(firstyear,lastyear); // modeled catch in numbers by year
  sdreport_vector CalcCatchIn1000tons(firstyear,lastyear);  //  Modelled catch
  vector CatchIn1000tons(firstyear,lastyear);  // Observed catch
  matrix CalcCatchInNumbers(firstyear,lastyear,firstage,lastage); // modelled catch in no by year and age
  vector meansel(firstage,lastage); // mean selection
  vector progsel(firstage,lastage); // selection in prognosis (last ?? years)
  vector ProgF(lastoptyear+1,lastyear);
  vector SigmaC(firstage,lastage);
  vector SigmaCinp(firstage,lastage);
  vector ProcessError(firstage,lastage);
  matrix basfunc(firstcatchage,lastage,1,Nbasfunc);



  vector Mdata(firstage,lastage); // input M as function of age;
  vector PredictedRecruitment(firstyear,lastyear);
  vector Recruitment(firstyear,lastyear);
  vector RecruitmentResiduals(firstyear,lastyear);


// Some reference values that later could be set as sdreport_vector

  vector RefBio1(firstyear,lastyear);
  vector RefBioHCR(firstyear,lastyear); // The refbio used in HCR 3.
  vector RefBioHCRwitherr(firstyear,lastyear); // The refbio with err used in HCR 3.
  vector SSBwitherr(firstyear,lastyear); // trigger bio.
  vector FishingYearTac(firstyear,lastyear); // Tac
  

  vector Finalpopulation(firstage,lastage);  
  sdreport_vector RefBio2(firstyear,lastyear);
  sdreport_vector N3(firstyear,lastyear);
  vector SWT6(firstyear,lastyear);
  vector SWT3(firstyear,lastyear);

  vector CbioR(firstyear,lastyear);
  vector Totbio(firstyear,lastyear);

// sdreport vectors that need to be set.  
  vector PredRefF(lastoptyear-5,lastyear); //sd
  vector PredSpawningstock(lastoptyear-5,lastyear); //sd
  vector PredN(lastoptyear-5,lastyear); //sd
  vector Survivors(firstage,lastage); //sd

  sdreport_vector RefF(firstyear,lastyear);
  sdreport_vector Spawningstock(firstyear,lastyear);
  sdreport_vector RelSpawningstock(firstyear,lastyear);
  vector SigmaSSBRec(firstyear,lastyear);
  vector EggProduction(firstyear,lastyear);
  vector TimeDrift(firstyear,lastyear); // Timedrift in Rmax in SSB-Recruitment relationship.  

  


// Surveys

  vector SurveyPropOfF(1,nsurveys); // Proportion of F before survey 
  vector SurveyPropOfM(1,nsurveys); // Proportion of M before survey 
  matrix SurveyResolution(1,nsurveys,firstage,lastage);  // must give all agegrups
  matrix SigmaSurveyInp(1,nsurveys,firstage,lastage);  // input from file.  
  matrix SigmaSurvey(1,nsurveys,firstage,lastage);
  matrix SurveylnQ(1,nsurveys,firstage,lastage);
  matrix SurveyPower(1,nsurveys,firstage,lastage);
  3darray ObsSurveyNr(1,nsurveys,firstyear,lastyear,firstage,lastage);
  3darray CalcSurveyNr(1,nsurveys,firstyear,lastyear,firstage,lastage);  
  3darray SurveyResiduals(1,nsurveys,firstyear,lastyear,firstage,lastage); 
  3darray SurveyWeights(1,nsurveys,firstyear,lastyear,firstage,lastage); 
  matrix SurveylnYeareffect(1,nsurveys,firstyear,lastyear);
  matrix ObsSurveyBiomass(1,nsurveys,firstyear,lastyear);
  matrix ObsSurveyTotnr(1,nsurveys,firstyear,lastyear);
  matrix CalcSurveyBiomass(1,nsurveys,firstyear,lastyear);
  matrix CalcSurveyTotnr(1,nsurveys,firstyear,lastyear);

  vector PropofFbeforeSpawning(firstcatchage,lastage);
  vector PropofMbeforeSpawning(firstcatchage,lastage);
  number RefSSB;
  number Minrelssb;
  number Maxrelssb; 



// Numbers related to HCR and stochasticity.  
  number CurrentTac;
  number TacLeft; 
  vector AssessmentErr(lastoptyear+1,lastyear);  
  vector recrerr(lastoptyear+1,lastyear);  // set here to get it global

  vector MeanSel(firstage,lastage);
 
  number CatchResolution; // Proportion 
  vector Likeliweights(1,10); 
  number sigmatotalcatch;
  vector LnLikelicomp(1,10);  // likelihood function

  number MaxFishMort;
  number largenumber;
  number LNMEANEFFORT;  // Temporary fix for likelihood component 9 (see evaluate_the_objective_function)
  objective_function_value LnLikely;





GLOBALS_SECTION
  #include <admodel.h>
  ofstream likelihood_mcmc("likelihood.mcmc");
  ofstream migration_mcmc("migration.mcmc");
  ofstream recruitment_mcmc("recruitment.mcmc");
  ofstream initpopulation_mcmc("initpopulation.mcmc");
  ofstream assessmentyearpopulation_mcmc("assessmentyear.mcmc");
  ofstream estimatedselection_mcmc("estimatedselection.mcmc");
  ofstream parameter_mcmc("parameter.mcmc");
  ofstream surveypower_mcmc("surveypower.mcmc");
  ofstream surveyq_mcmc("surveyq.mcmc");
  ofstream effort_mcmc("effort.mcmc");
  ofstream catch_mcmc("catch.mcmc");
  ofstream assessmenterror_mcmc("assessmenterror.mcmc");
  ofstream refbio_mcmc("refbio.mcmc");
  ofstream refbiohcrwitherr_mcmc("refbiohcrwitherr.mcmc");
  ofstream ssbwitherr_mcmc("ssbwitherr.mcmc");
  ofstream fishingyeartac_mcmc("fishingyeartac.mcmc");
  ofstream n3_mcmc("n3.mcmc");
  ofstream f_mcmc("f.mcmc");
  ofstream ssb_mcmc("ssb.mcmc");
  ofstream relssb_mcmc("relssb.mcmc");
  ofstream swt6_mcmc("swt6.mcmc");
  ofstream cbior_mcmc("cbior.mcmc");
  ofstream ssbrec_mcmc("ssbrec.mcmc");
  ofstream swt3_mcmc("swt3.mcmc");
  ofstream refbiohcr_mcmc("refbiohcr.mcmc");
  ofstream finalpopulation_mcmc("finalpopulation.mcmc");

  ofstream chains_like("chains_like.mcmc");
  ofstream chains_par("chains_par.mcmc");
  ofstream chains_age("chains_age.mcmc");
  ofstream chains_year("chains_year.mcmc");

  ofstream outputrule5("outputrule5.txt");
  
TOP_OF_MAIN_SECTION
  gradient_structure::set_CMPDIF_BUFFER_SIZE(10000000);
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(1000000);
  gradient_structure::set_MAX_NVAR_OFFSET(1500);
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(1500);
  arrmblsize = 50000000;


RUNTIME_SECTION 
  convergence_criteria .1, .01, .0001, .0000001
  maximum_function_evaluations 800000
 

PRELIMINARY_CALCS_SECTION
  outputrule5 << "year" << " " <<  "ssb" << " " << "ssbwitherr" << " " << "baseHR" << " " << "Hratio" << " " << "refbio" << " " << " " << "refbiohcrwitherr" << " " << "Catch" << endl; 

 COUNTER = 0;
// Some dummy values 
// Parameters that are sometimes estimated.  
  Surveycorr = 0.601; 
  RefSSB = 150;  //Was 1000 
  Maxrelssb = 500; // Was 1000
  Minrelssb = 0; 

 
  AssessmentErr = 0;  // Set in sd_phase
  int i;
  SurveyPower = 1; 
  for(i = 1; i <= nsurveys; i++) SurveyPowerest(i) = 1; 
  SigmaSurveypar = log(0.25);
  SurveylnQ = -100;
  for(i = 1; i <= nsurveys; i++) SurveyPowerest(i) = 1; 

  for(i = firstyear; i <= lastoptyear; i++) Fpar(i) = 0;

  Catchlogitslope = 1;
  Catchlogitage50 = 5;
  SigmaSurveypar = log(0.25);
  lnMeanRecr = 11.3; // 200 million
  lnMeanInitialpop = 11;
  lnMeanEffort = -0;
  for( i = 1; i <= 4; i++) estSSBRecParameters(i) = log(SSBRecParameters(i));
  for( i = 5; i <= 6; i++) estSSBRecParameters(i) = SSBRecParameters(i);


   MaxFishMort = 1.5; // Maximum modelled fishing mortality
   largenumber = 10000;
   TimeDrift = 0;
   CatchWeights = SSBWeights = StockWeights = StockMaturity = 0;
   ObsCatchInNumbers  = CatchDiff =  -1;
   CatchIn1000tons = -1;

   PredictedRecruitment = RecruitmentResiduals = Recruitment =-1;
   for(i = 1; i <= nsurveys; i++ ) ObsSurveyNr(i) = 0.0; 
   cout << "ReadCatchandStockData " << endl;
   ReadCatchandStockData();
   cout << "ReadStockParameters " << endl;
   ReadStockParameters();
   cout << "ReadCatchParameters " << endl;
   ReadCatchParameters();
   cout << "ReadLikelihoodParameters " << endl;
   ReadLikelihoodParameters();
   cout << "ReadOutputParameters " << endl; 
   ReadOutputParameters();
   
    ReadPrognosis();
    for(i = 1; i <= nsurveys; i++) 
     SurveyWeights(i) = StockWeights;  // Changed if weights are read from file.
   adstring parameterfilename;
   adstring datafilename; 
   adstring residualfilename;
   ifstream surveylistfile("SURVEYFILES.DAT");
   ofstream surveylogfile("survey.log");
   for( i = 1; i <= nsurveys; i++) {
      surveylistfile >>  parameterfilename;
      surveylistfile >>  datafilename;
      surveylistfile >>  residualfilename;
       ReadSurveyInfo(parameterfilename,datafilename,residualfilename,i,surveylogfile);
   }
//   WriteInputDataInMatrixForm();  // For user to look at.  


  for(i = firstyear; i <= lastdatayear ; i++) 
      CatchIn1000tons(i) = sum(elem_prod(CatchWeights(i),ObsCatchInNumbers(i)))/1.0e6;
  
  assessmentyearpopulation_mcmc_lines = 0;
  likelihood_mcmc_lines = 0;
  migration_mcmc_lines = 0;
  recruitment_mcmc_lines = 0;
  initpopulation_mcmc_lines = 0;
  estimatedselection_mcmc_lines = 0;
  parameter_mcmc_lines = 0;
  surveypower_mcmc_lines = 0;
  surveyq_mcmc_lines = 0;
  effort_mcmc_lines = 0;
  catch_mcmc_lines = 0;
  assessmenterror_mcmc_lines = 0;
  refbio_mcmc_lines = 0;
  refbiohcrwitherr_mcmc_lines = 0;
  ssbwitherr_mcmc_lines = 0;
  fishingyeartac_mcmc_lines = 0;

  f_mcmc_lines = 0;
  ssb_mcmc_lines = 0;

  mcmc_iteration = 1;

PROCEDURE_SECTION
//  cout << "StartHistoricalSimulation" << endl;
  HistoricalSimulation();
  COUNTER = COUNTER + 1;
//  cout << "StartPrognosis " << endl;
  // SetPredValues();  // Set various sdreport objects from bw.tpl NPEL2007
  Prognosis();
  evaluate_the_objective_function();
  if(mceval_phase()){
    write_mcmc();  // Main printing routine.  
//    write_mcmc_long();
 }
REPORT_SECTION
   report << "LnLikelicomp" <<  LnLikelicomp << endl;
   report << "Surveylikelihood " << Surveylikelihood << endl;
   report << endl << "SigmaSurvey " << endl << SigmaSurvey << endl;

   int i,j;
   ofstream outfile("resultsbyyearandage");
   outfile << "year\t age\t N \t Z\t StockWeights\t M\t F\t CalcCno\t CatchWeights\t SSBWeights\t StockMaturity\tObsCno\t CatchDiff";
   for(i = 1; i <= nsurveys; i++) 
      outfile << "\tCalcSurveyNr" << i <<"\tObsSurveyNr" << i <<"\tSurveyResiduals" << i;
   outfile  << endl;


   int k;
   for(i = firstyear ; i <= lastyear; i++) {
     for(j = firstage; j <= lastage; j++) {
        outfile << i << "\t" << j << "\t" << N(i,j) << "\t" << Z(i,j) << "\t" << StockWeights(i,j) << "\t" << natM(i,j) << "\t" ;
       outfile << F(i,j) << "\t" << CalcCatchInNumbers(i,j) << "\t" << CatchWeights(i,j) << "\t" << SSBWeights(i,j) << "\t" <<  StockMaturity(i,j) << "\t";
       outfile << ObsCatchInNumbers(i,j) << "\t" << CatchDiff(i,j);
       for(k = 1; k<= nsurveys; k++) 
         outfile << "\t" <<  CalcSurveyNr(k,i,j) << "\t" << ObsSurveyNr(k,i,j) << "\t" << SurveyResiduals(k,i,j) ;
       outfile << endl;
    }
   }
   outfile.close() ;


   outfile.open("resultsbyyear"); 

  outfile << "year\t RefF\t CalcCatchIn1000tons\tCatchIn1000tons\tSpawningstock\tEggproduction\tCbioR\tRefBio1\tRefBio2\tPredictedRecruitment\tRecruitment\tN1\tN3\tN6";
  for(i = 1; i <= nsurveys; i++) 
   outfile << "\tCalcSurveyBiomass"<<i<<"\tObsSurveyBiomass"<<i;
  outfile << endl;

  for(i = firstyear; i <= lastyear; i++) {
    outfile << i << "\t" <<  RefF(i) << "\t" <<  CalcCatchIn1000tons(i) << "\t" << CatchIn1000tons(i) << "\t" << Spawningstock(i) << "\t" << EggProduction(i) << "\t" << 
     CbioR(i) << "\t" << RefBio1(i) << "\t" << RefBio2(i) << "\t" << PredictedRecruitment(i) << "\t" << Recruitment(i) << "\t" << N(i,firstage) << "\t" << N(i,3) << "\t" << N(i,6) ;
    for(j = 1; j <= nsurveys; j++) 
      outfile << "\t" << CalcSurveyBiomass(j,i) << "\t" << ObsSurveyBiomass(j,i); 
    outfile  << endl;
   }

   outfile.close(); 

   outfile.open("resultsbyage");
 
  outfile << "age\tmeansel\tprogsel\tSigmaC";
  for(i = 1; i <= nsurveys; i++) 
    outfile << "\tSigmaSurvey" << i << "\tSurveylnQ" << i << "\tSurveyPower" << i;
  outfile << endl;

  for(i = firstage; i <= lastage; i++) {
    outfile << i << "\t" <<  meansel(i) << "\t" << progsel(i) << "\t" << SigmaC(i);
    for(j = 1; j <= nsurveys; j++){ 
       if(i >= surveyfirstage(j) | i <= surveylastage(j)) 
         outfile << "\t" <<  SigmaSurvey(j,i) << "\t" << mfexp(SurveylnQ(j,i)) << "\t" << SurveyPower(j,i); 
       else 
         outfile << "\t-1\t-1\t-1"; 
     }
    outfile << endl;

  }
  outfile.close();
 

//**********************************************************

FUNCTION void HistoricalSimulation()
  int i;
  int trend = 0;  // Trend or shift in 1985.  
  if(trend == 1) {
    TimeDrift(firstyear) = 0; 
    for(i = firstyear+1; i <= lastoptyear-5 ;i++)     
      TimeDrift(i) = TimeDrift(i-1) +  estSSBRecParameters(6); 
// Stop trend
    for(i = lastoptyear-4; i <= lastyear ;i++)     
      TimeDrift(i) = TimeDrift(i-1); 
 }
 if(trend == 0)  { // shift 1985
    for(i = firstyear+1; i <= 1985 ;i++)     
      TimeDrift(i) = 0;
    for(i = 1986 ; i <= lastyear ; i++) 
      TimeDrift(i) =  estSSBRecParameters(6);
 }



  int HistoricalAssessment = 1;
  N = 0;
// Migrations are not included in prognosis in retros.  
  for(i = 1; i <= MigrationNumbers ; i++) 
    if(int(MigrationYears(i)) >= firstyear & int(MigrationYears(i)) <= lastoptyear & 
      int(MigrationAges(i)) >= firstage  & int(MigrationAges(i)) <= lastage)
      N(int(MigrationYears(i)),int(MigrationAges(i))) +=mfexp(lnMigrationAbundance(i));
  for(i = firstyear; i <=  lastoptyear-recrdatadelay+firstage; i++ ) { 
    N(i,firstage) += mfexp(lnMeanRecr+lnRecr(i));
    if(i - firstage >= firstyear) 
        Recruitment(i-firstage) = N(i,firstage);
   }

   for(i = firstage+1; i <= lastage; i++) 
     N(firstyear,i) = mfexp(lnMeanInitialpop+lnInitialpop(i));
  for(i = firstyear; i <= lastoptyear ;i++){
    CalcNaturalMortality1(i);
    CalcFishingMortality1b(i);
    Z(i) = F(i) + natM(i) ;
    if(i > lastoptyear-recrdatadelay+firstage) {
       PredictSSB(i-firstage);
       PredictedRecruitment(i-firstage) = PredictRecruitment(i-firstage);
       Recruitment(i-firstage) = PredictedRecruitment(i-firstage);
       N(i,firstage) = PredictedRecruitment(i-firstage);
    }
    CalcCatchInNumbers(i)=elem_prod(elem_div(F(i),Z(i)),elem_prod((1.-mfexp(-Z(i))),N(i)));
    CalcCatchIn1000tons(i) = sum(elem_prod(CalcCatchInNumbers(i),CatchWeights(i)))/1.0e6;
    CalcNextYearsN(i);
   }
 
// Calculate reference biomasses, mean selection, selection last 5 years etc.  
// The switch Historical Assessment is to have meansel and progsel calculated first.  
   CalcRefValues(firstyear,lastoptyear,HistoricalAssessment);   
   if(recrdatadelay > 0) {     
      for(i = lastoptyear-recrdatadelay+1; i <= lastoptyear; i++){
          PredictedRecruitment(i) = PredictRecruitment(i);
          Recruitment(i) = PredictedRecruitment(i);
      }
    }

    
// *****************************************************

// The Harvest control rule most used in the simulations.  


FUNCTION void HCRRatioOfBiomass(int yr)
// Calculation of spawning stock in assessment year yr. Used as trigger.   
   int age;
   dvariable tmpssb = 0.0;
   for(age = minssbage; age <= lastage; age++)
     tmpssb += N(yr,age)*SSBWeights(yr,age)*StockMaturity(yr,age)*
     mfexp(-(natM(yr-1,age)*PropofMbeforeSpawning(age)+F(yr-1,age)*PropofFbeforeSpawning(age))); 
   tmpssb/= 1.0e6;
   dvariable LastTacratio;
   dvariable PAratio;

   SSBwitherr(yr) = mfexp(log(tmpssb)+AssessmentErr(yr)); // Assessment err added.  
   PAratio = SSBwitherr(yr)/Btrigger;
   if(PAratio > 1) PAratio = 1;

// Condition based on how the stabilizer behaves below Btrigger.  2 unchanged, 1 continuous decline, 0 no 
// Stabilizer below Btrigger.  

   if(RatioCurrentTacUnchangedBelowBtrigger==2) {
     LastTacratio = RatioCurrentTac; }// Stabilizer unchanged below Btrigger.  
   else if(RatioCurrentTacUnchangedBelowBtrigger==1){
     LastTacratio = RatioCurrentTac*PAratio;}  // Continuous stabilizer

   else if(RatioCurrentTacUnchangedBelowBtrigger==0)  // Stabilizer removed below Btrigger.  
   { if(PAratio < 1) LastTacratio = 0; else LastTacratio = RatioCurrentTac;}

   dvariable MaxHarvestRatio = 0.65; // Maximum removal
   dvariable Catch;
   dvariable AnnualCatch;  
   dvariable mincatch = 0.0;
   dvariable refbio;
   refbio = CalcHCRRefBio(yr);  // Reference biomass
   RefBioHCR(yr) = refbio;  
   RefBioHCRwitherr(yr) = mfexp(log(refbio)+AssessmentErr(yr));
   dvariable refcatch = PAratio*HarvestRatio*RefBioHCRwitherr(yr);
   Catch = LastTacratio*CurrentTac +  (1-LastTacratio)*refcatch;  // ratio decreases below Btrigger.  
   Catch = SmoothDamper(Catch,MaxHarvestRatio*refbio,mincatch);  // Smooth damper is just a differentiable if.  In principle 
   	   							 // not required here as this is run in the mceval phase.  
   FishingYearTac(yr) = Catch;  // Fishing year starting September 1st.  

// Conversion to annual  catch.  
   AnnualCatch =  TacLeft + Catch/3; 
   AnnualCatch = SmoothDamper(AnnualCatch,MaxHarvestRatio*refbio,mincatch);   //
   TacLeft = Catch*2/3;
   CurrentTac = Catch;  
   ProgF(yr) = FishmortFromCatch(AnnualCatch,N(yr),CatchWeights(yr),progsel,natM(yr));
// Same as  HCRRatioOfBiomass except the Ratio is not constant.  Made because of a request to look 
// at HCR where harvest ratio was increased when stock was large. HCRRatioOfBiomass is really a special 
// case of this rule, still decided to keep the code seperate.  Not used in HCR evaluations.  Rule 5 .  

//****
FUNCTION void HCRRatiosOfBiomass(int yr)
// Adapt to Fishing Years.  
   //dvariable HarvestRatio = 0.2;
   int age;
   dvariable tmpssb = 0.0;
   for(age = minssbage; age <= lastage; age++)
     tmpssb += N(yr,age)*SSBWeights(yr,age)*StockMaturity(yr,age)*
     mfexp(-(natM(yr-1,age)*PropofMbeforeSpawning(age)+F(yr-1,age)*PropofFbeforeSpawning(age))); 
   tmpssb/= 1.0e6;

   dvariable MaxHarvestRatio = 0.65; 
   dvariable Catch;
   dvariable AnnualCatch;  
   dvariable mincatch = 0.0;
   dvariable refbio;

   refbio = CalcHCRRefBio(yr);
   RefBioHCR(yr) = refbio;  
   dvariable refbiowitherr = mfexp(log(refbio)+AssessmentErr(yr))/1.0e6;
   RefBioHCRwitherr(yr) = refbiowitherr*1.0e6;  // divide by it later

   dvariable ratio;
   dvariable Hratio;
   dvariable BaseHratio;
   dvariable tmpssbwitherr =  mfexp(log(tmpssb)+AssessmentErr(yr)); 
   SSBwitherr(yr) = tmpssbwitherr;

   if( refbiowitherr  < Refbiobreak1) BaseHratio=HarvestRatio1;
   if(  refbiowitherr  > Refbiobreak2) BaseHratio=HarvestRatio2;
   if(  refbiowitherr  > Refbiobreak1 && refbiowitherr  < Refbiobreak2) 
        BaseHratio=HarvestRatio1+(refbiowitherr -Refbiobreak1)
	/(Refbiobreak2-Refbiobreak1)*(HarvestRatio2-HarvestRatio1);


   ratio =  tmpssbwitherr /Btrigger;
   if(ratio > 1) ratio = 1;
   Hratio = ratio*BaseHratio; 
   dvariable refcatch = Hratio*mfexp(log(refbio)+AssessmentErr(yr));
   
   if(RatioCurrentTacUnchangedBelowBtrigger==2) {
     ratio = RatioCurrentTac;} // Stabilizer unchanged below Btrigger.  
   else if(RatioCurrentTacUnchangedBelowBtrigger==1){
     ratio = RatioCurrentTac*ratio; } // Stabilizer less effective below Btrigger could be made discontinuous
   else if(RatioCurrentTacUnchangedBelowBtrigger==0) // No stabilizer below btriger
   { if(ratio < 1) ratio = 0; else ratio = RatioCurrentTac;}   
   

   Catch = ratio*CurrentTac +  (1-ratio)*refcatch;  // ratio decreases below Btrigger.  
   Catch = SmoothDamper(Catch,MaxHarvestRatio*refbio,mincatch);
   AnnualCatch =  TacLeft + Catch/3; 
   AnnualCatch = SmoothDamper(AnnualCatch,MaxHarvestRatio*refbio,mincatch); 
   TacLeft = Catch*2/3;
   CurrentTac = Catch;  
   ProgF(yr) = FishmortFromCatch(AnnualCatch,N(yr),CatchWeights(yr),progsel,natM(yr));
   outputrule5 << yr << " " <<  tmpssb << " " << tmpssbwitherr << " " << BaseHratio << " " << Hratio << " " << refbio/1.0e6 << " " << " " << mfexp(log(refbio)+AssessmentErr(yr))/1.0e6 << " " << Catch/1.0e6 << endl ;

// Added 17/2 2012 for clarity.     
FUNCTION dvariable CalcHCRRefBio(int yr)
   int refage = HCRrefage;
  dvariable refbio;
  if(UseStockWeights == 1)
     refbio = sum(elem_prod(N(yr)(refage,lastage),StockWeights(yr)(refage,lastage))); // Stockweights
   else
     refbio = sum(elem_prod(N(yr)(refage,lastage),CatchWeights(yr)(refage,lastage))); // Catchweights 
   return(refbio);

FUNCTION void SetAssessmentErr()
  random_number_generator r(COUNTER+20000);  // To avoid correlation with recrerr
  dvariable ratio = sqrt(1-Assessmentcorr*Assessmentcorr);
  int i;
  for(i = lastoptyear+1; i <= lastyear; i++)
    AssessmentErr(i) = randn(r);
// We have assumed som value in the assessment if it is higher than ther real value then we are overestimating.  
  AssessmentErr(lastoptyear+1) = log(EstimatedAssYearRefBio/CalcHCRRefBio(lastoptyear+1)*1.0e6)/ratio/Assessmentcv;
  for(i = lastoptyear+2; i <= lastyear; i++)
    AssessmentErr(i) = Assessmentcorr*AssessmentErr(i-1)+AssessmentErr(i);  
  AssessmentErr=AssessmentErr*Assessmentcv*ratio;


// Set Recruitement and assessment error 


FUNCTION void Prognosis()

//Catchrule 1 TAC, 2 Tac in advisory year F there after trigger in F, 
//3 HCR proportion of Biomass 4 F all years, 
  dvariable ratio;
  int lastprogyear; // To reduce computer time in early part of simulation
  if ( current_phase() < 4) 
    lastprogyear = lastoptyear + 2; 
  else 
    lastprogyear = lastyear;
  CurrentTac= CurrentTacInput*1e6; // For catch rule start value.  
  TacLeft = TacLeftInput*1e6;  // For catch rule start value.  
  int i;
//  UpdateWeightsAndMaturity() has to be called every year if 
//  Weights are linked to stocksize. 
// Change here with regards to treatment of AssessmentError in the assessment year.  
   if(mceval_phase() || mceval_phase()){
     dvariable CurrentStockError;

     random_number_generator r(COUNTER+20000111);  // To avoid correlation with other errors
     CurrentStockError = randn(r)*CurrentAssessmentErrmultiplier*Assessmentcv; // scale the stock error is stock/presumed stock     
     UpdateWeightsAndMaturity(); 
     N(lastoptyear+1)= N(lastoptyear+1)*CurrentStockScaler; // Scale down the stock in the assessment year.  
     N(lastoptyear+1)=mfexp(log(N(lastoptyear+1))-CurrentStockError); // 
     SetAssessmentErr();
   }
// Set Assessment error 

  random_number_generator r(COUNTER+40000) ;  //stoch
// mceval_phase does not work
 if(mceval_phase()|| mceval_phase()) {
    dvariable recrratio = sqrt(1-Recrcorr*Recrcorr);
    for(i = lastoptyear+1; i <= lastyear; i++)
      recrerr(i) = randn(r);
    recrerr(lastoptyear+1) = recrerr(lastoptyear+1)/recrratio;
    for(i = lastoptyear+2; i <= lastyear; i++)
      recrerr(i) = Recrcorr*recrerr(i-1)+recrerr(i);
    recrerr=recrerr*recrratio;
  }
  dvariable Catch;
  for(i = lastoptyear+1; i <= lastprogyear; i++) {
    CalcNaturalMortality1(i); 
    //CalcRefValues(i,i,0);  // can not be called here for some reason
    if(firstcatchage == 0){ // Have to do it here if 0group is caught.  
       PredictSSB(i);  // Then SSB must be at the start of the year.
       PredictedRecruitment(i) = mfexp(log(PredictRecruitment(i))+recrerr(i)*SigmaSSBRec(i));
       N(i,firstage) = PredictedRecruitment(i-firstage);
    } 
    // Tac 
    if(CatchRule == 1 || i <= lastdatayear) {  
        if(current_phase() < 4) // have to start with F for convergence
           ProgF(i) = 0.5;
        else {
          if(i > lastdatayear) 
            Catch = FutureForCatch(i)*1e6; // right units for the program (kgs)
          else 
            Catch = CatchIn1000tons(i)*1e6;
	  ProgF(i) = FishmortFromCatch(Catch,N(i),CatchWeights(i),progsel,natM(i));
        }
    }

//  Fishing mortality for all years.  Problems with tac constraint in estimation.  
    if(CatchRule == 4){
        ProgF(i) = mfexp(log(FutureForCatch(i))+AssessmentErr(i));
    }
 
//  Fishing mortality Trigger.      
    if(CatchRule == 2 & i > lastdatayear){
      if(i == lastdatayear+1) {// Tac in assessment year. 
         if(current_phase() <= 5) // have to start with F for convergence
           ProgF(i) = 0.5;
	 if(current_phase() > 5) 
	      ProgF(i) = FishmortFromCatch(FutureForCatch(i)*1e6,N(i),CatchWeights(i),progsel,natM(i));
      }
      else {
        ratio = mfexp(log(Spawningstock(i-1))+AssessmentErr(i))/Btrigger;
	if(ratio > 1) ratio = 1;
        ProgF(i) = mfexp(log(FutureForCatch(i)*ratio)+AssessmentErr(i));
      }
    }
 
    if(CatchRule == 3 & i > lastdatayear)
      HCRRatioOfBiomass(i);  // The HCR for Icelandic saithe.  
    if(CatchRule == 5 & i > lastdatayear)
      HCRRatiosOfBiomass(i);  // Harvest ratio allowed to change with stock size
    F(i) = ProgF(i)*progsel; 
    Z(i) = F(i) + natM(i);
    if(firstcatchage > 0 & i > (lastoptyear+firstage-recrdatadelay) ) {
	 PredictSSB(i);
         PredictedRecruitment(i) = mfexp(log(PredictRecruitment(i))+recrerr(i)*SigmaSSBRec(i));
         Recruitment(i) = PredictedRecruitment(i);
  	 N(i,firstage) = PredictedRecruitment(i-firstage);
    }

     if(firstcatchage > 0 & i <= (lastoptyear+firstage-recrdatadelay) ){
	 PredictSSB(i);
         PredictedRecruitment(i) = mfexp(log(PredictRecruitment(i))+recrerr(i)*SigmaSSBRec(i));
         Recruitment(i) = PredictedRecruitment(i);
    }
    CalcCatchInNumbers(i)=elem_prod(elem_div(F(i),Z(i)),elem_prod((1.-mfexp(-Z(i))),N(i)));
    CalcCatchIn1000tons(i) = sum(elem_prod(CalcCatchInNumbers(i),CatchWeights(i)))/1.0e6;
    CalcNextYearsN(i);
    CalcRefValues(i,i,0); // called again as some values change with catch 
  } 
  Finalpopulation = N(lastyear-1);


// ******************************************************************
// Objective function; 
// This function calls a set of routines that do the job.  

FUNCTION void evaluate_the_objective_function()
    LnLikelicomp = 0;
   int i,j;
   LnLikelicomp(1) = Catch_loglikeliNocorr();
 
// Variations in Total catch  sigmatotalcatch is typically low to 
// follow catch well. 

   LnLikelicomp(4) = sum(square(log(CatchIn1000tons(firstyear,lastoptyear))
	-log(CalcCatchIn1000tons(firstyear,lastoptyear))))/
	  (2.*square(sigmatotalcatch))+ noptyears*log(sigmatotalcatch);

  LnLikelicomp(2) = SSB_Recruitment_loglikeli(); 
  for(i = 1; i <= nsurveys; i++) {
      Surveylikelihood(i) = Survey_loglikeli1(i); // Store by survey
      LnLikelicomp(3) +=  Surveylikelihood(i);
  }

  LnLikelicomp(8) = 0; 


//  dvariable effortsigma = 0.5; // Depends on the version used
//  for(i = firstyear ; i <= lastoptyear-1; i++) 
//    for(j = 1; j <= 4; j++) 
//       LnLikelicomp(8) += square(Fpar(i+1,j)-Fpar(i,j))/(2*square(effortsigma))+log(effortsigma); 

//
  dvariable SigmaEffort = 0.5; 
  if(current_phase() < 5) LNMEANEFFORT = lnMeanEffort;
  else LnLikelicomp(9) = 0.5*square((lnMeanEffort- LNMEANEFFORT)/SigmaEffort);// Help toward the correct solution ?? 5 is really enough.   
//   for(i = firstyear ; i < lastoptyear ; i++) 
//     LnLikelicomp(9) +=  0.5*square((lnEffort(i+1)-lnEffort(i))/SigmaEffort) + log(SigmaEffort);

  LnLikely = 0;
//  cout << "Lnlikelicomp " << LnLikelicomp << endl;
  for(i = 1; i <= 10; i++) 
     LnLikely += LnLikelicomp(i)*Likeliweights(i);
//  cout << "totalloglikeli " << LnLikely << endl;


//**************************************************************
// Calculate N for next year based on Z. 
// N has been set to zero initially and += is because the migrations were 
// set in the beginning.  
 
FUNCTION void CalcNextYearsN(int year)
   int age;
   if(year < lastyear) {
     for (age = firstage;age < lastage; age++)
       N(year+1,age+1) += N(year,age)*mfexp(-Z(year,age));
      if(plusgroup == 1)  N(year+1,lastage) += N(year,lastage)*mfexp(-Z(year,lastage));
   }




//*****************************************************************
// Logit function simplest version;
FUNCTION void CalcFishingMortality1(int year) 
   int age;
   for(age = firstcatchage; age <= lastage; age++) 
      F(year,age) = mfexp(lnMeanEffort+lnEffort(year))*1/(1+mfexp(-Catchlogitslope*(age-Catchlogitage50)));


// Logit function with proportion of an age group put in as a multiplier i.e more for larger yearclasses.   
FUNCTION void CalcFishingMortality3(int year) 
   int age;
   dvariable Biomass = 0; 
   dvar_vector proportion(firstage,lastage);
   proportion = 0;
   for( age = firstcatchage; age <= lastage; age++) 
      Biomass += N(year,age)*StockWeights(year,age);
   for( age = firstcatchage; age <= lastage; age++) 
      proportion(age) = N(year,age)*StockWeights(year,age)/Biomass;
   
   for(age = firstcatchage; age <= lastage; age++) 
      F(year,age) = mfexp(lnMeanEffort+lnEffort(year))*1/(1+mfexp(-Catchlogitslope*(age-Catchlogitage50)+proportion(age)*AbundanceMultiplier));                 



   


FUNCTION void CalcNaturalMortality1(int year)
   int i;
   int j;
   dvariable age;
   for(j = firstage; j <= lastage; j++)
	natM(year,j) = Mdata(j);

// ****************************************************
// Likelihood function for Catch in numbers.  
// No correlation between age groups.  

FUNCTION dvariable Catch_loglikeliNocorr()
 dvariable value = 0;
 dvariable totalnumber = 0;
 int i,j;
 for(i = firstcatchage;i <= lastage; i++) 
    SigmaC(i) = SigmaCinp(i)*mfexp(logSigmaCmultiplier);
  if(CatchRobust == 0) { // Not use robust function for catch
    for(i = firstyear; i <=  lastoptyear; i++) {
     totalnumber = 0;
     for( j = firstcatchage; j <= lastage; j++)
       totalnumber+=ObsCatchInNumbers(i,j);
     for( j = firstcatchage; j <= lastage; j++) {
         if(ObsCatchInNumbers(i,j) != -1) {
           CatchDiff(i,j) = log( (ObsCatchInNumbers(i,j)+CatchResolution*totalnumber)/
           (CalcCatchInNumbers(i,j)+CatchResolution*totalnumber) );
           value += 0.5*square(CatchDiff(i,j)/SigmaC(j)) + log(SigmaC(j));
         }
      } 
    }
  }

  if(CatchRobust == 1) {
    dvariable diff2;
    dvariable v_hat;
     dvariable e = exp(1);
    dvariable pcon = 0.15;
    dvariable b = 2*pcon/(1.772454*e);
    for(i = firstyear; i <=  lastoptyear; i++) {
      for( j = firstcatchage; j <= lastage; j++) {
        if(ObsCatchInNumbers(i,j) != -1) {
          CatchDiff(i,j) = log( (ObsCatchInNumbers(i,j)+CatchResolution)/(CalcCatchInNumbers(i,j)+CatchResolution) );
          diff2 = square(CatchDiff(i,j));
          v_hat = square(SigmaC(j));
          value += log(v_hat) - log((1-pcon)*exp(-diff2/(2*v_hat))+b/(1.+square(diff2/(square(e)*v_hat))));
       }
      }
    }
   }


 return value;



// ***************************************************************************
// Predicts survey abundance by a power model an possibly year effect.  
FUNCTION void PredictSurveyAbundance1(int surveynr)

// Survey indices Look if surveylastyear > nyrs Add time of year that survey takes place.
  int finalyear =  min(lastoptyear+surveytimefromlastyear(surveynr),surveylastyear(surveynr));
  dvariable value = 0;
   SurveyPower(surveynr)(surveyfirstage(surveynr),surveylastage(surveynr)) = 1;  // Changed for youngest fish.  
  int i;
  int j;
 
// guess  when SurveylnQ is not active.  power is 1 in that case.  
// not use the survey further than nyrs+1 or even nyrs in some cases
// if survey is not available at the time of assessment. The division 
// by  surveylastyear-surveyfirstyear+1 is not exact if there are missing 
// years in between but gives good enough results as initial guess.  

    if(!active(SurveylnQest )) {
      for(j = surveyfirstage(surveynr); j <= surveylastage(surveynr); j++){
        SurveylnQ(surveynr,j) = 0; 
        for(i = surveyfirstyear(surveynr); i <= finalyear; i++) {
          if(ObsSurveyNr(surveynr,i,j) != -1) 
            SurveylnQ(surveynr,j) += log((ObsSurveyNr(surveynr,i,j)+SurveyResolution(surveynr,j))/N(i,j));
        }
     }
     SurveylnQ(surveynr)/= (finalyear-surveyfirstyear(surveynr)+1);
     SurveylnQest(surveynr) = SurveylnQ(surveynr)(SurveylnQest(surveynr).indexmin(),SurveylnQest(surveynr).indexmax());
 }
  else {
   for( j  = surveyfirstage(surveynr); j <= surveyfirstagewithfullcatchability(surveynr); j++)
     SurveylnQ(surveynr,j) = SurveylnQest(surveynr,j);
   for( j  = surveyfirstagewithfullcatchability(surveynr); j <= surveylastage(surveynr); j++)
     SurveylnQ(surveynr,j) = SurveylnQest(surveynr,surveyfirstagewithfullcatchability(surveynr));
   for(j = surveyfirstage(surveynr); j <  surveyfirstagewithconstantcatchability(surveynr); j++)
    SurveyPower(surveynr,j) = SurveyPowerest(surveynr,j);

  }
  dvariable pZ;
  for( i = surveyfirstyear(surveynr); i <= finalyear; i++) {
    for(j = surveyfirstage(surveynr); j <= surveylastage(surveynr); j++) {
      pZ = SurveyPropOfF(surveynr)*F(i,j)+SurveyPropOfM(surveynr)*natM(i,j);
      CalcSurveyNr(surveynr,i,j) = mfexp(log(N(i,j)*mfexp(-pZ))*SurveyPower(surveynr,j)+SurveylnQ(surveynr,j)
      +SurveylnYeareffect(surveynr,i));
      if(j == 1 && i > 2002) CalcSurveyNr(surveynr,i,j)*= mfexp(logChangeInQage1MarchSince2003);  // Very special for age 1 after 2002.  
    }
  }
  for(i = surveyfirstyear(surveynr); i <= finalyear ; i++) {
    CalcSurveyBiomass(surveynr,i) = sum(elem_prod(CalcSurveyNr(surveynr,i),SurveyWeights(surveynr,i)));
    CalcSurveyTotnr(surveynr,i) = sum(CalcSurveyNr(surveynr,i));
  }


// Matrix to invert has to start at 1 (or it was at least that way)
FUNCTION  dvariable Survey_loglikeli1(int surveynr)
  PredictSurveyAbundance1(surveynr); 
  dvar_matrix Scorrmat(1,surveylastage(surveynr)-surveyfirstage(surveynr)+1,1,surveylastage(surveynr)-surveyfirstage(surveynr)+1);
  dvar_vector SurveyDiff(1,surveylastage(surveynr)-surveyfirstage(surveynr)+1);
  dvariable SurveylnDet;  

  dvariable value = 0;
  int i; 
  int j; 
  int k; 
  int finalyear =  min(lastoptyear+surveytimefromlastyear(surveynr),surveylastyear(surveynr));
  for(i = surveyfirstage(surveynr); i <= surveylastage(surveynr); i++) 
    SigmaSurvey(surveynr,i) = SigmaSurveyInp(surveynr,i)*mfexp(SigmaSurveypar(surveynr));

  for(j = 1; j <= surveylastage(surveynr)-surveyfirstage(surveynr)+1; j++) {  
     Scorrmat(j,j) = 1.0*square(SigmaSurvey(surveynr,j+surveyfirstage(surveynr)-1));
     for(k = 1 ; k < j; k++) {
       Scorrmat(j,k) = pow(Surveycorr(surveynr),j-k)*SigmaSurvey(surveynr,j+surveyfirstage(surveynr)-1)*SigmaSurvey(surveynr,k+surveyfirstage(surveynr)-1);
       Scorrmat(k,j) = Scorrmat(j,k);
     }
  }
  SurveylnDet = log(det(Scorrmat));
  Scorrmat = inv(Scorrmat);

  if(SurveyRobust == 0) {
    for( i = surveyfirstyear(surveynr); i <=  finalyear; i++) {
      for(j = surveyfirstage(surveynr); j <= surveylastage(surveynr); j++) {
        if(ObsSurveyNr(surveynr,i,j) != -1) {
          SurveyResiduals(surveynr,i,j) = log( (ObsSurveyNr(surveynr,i,j)+SurveyResolution(surveynr,j))/
	  (CalcSurveyNr(surveynr,i,j)+SurveyResolution(surveynr,j)) );
	  SurveyDiff(j-surveyfirstage(surveynr)+1) =  SurveyResiduals(surveynr,i,j);
        }
      }
      value  += 0.5*(SurveylnDet)+0.5*SurveyDiff*Scorrmat*SurveyDiff;
    }
  }
  if(SurveyRobust == 1) {  // multivariate version not ready.  
    dvariable diff2;
    dvariable v_hat;
     dvariable e = exp(1);
    dvariable pcon = 0.15;
    dvariable b = 2*pcon/(1.772454*e);
     for( i = surveyfirstyear(surveynr); i <=  finalyear; i++) {
      for(j = surveyfirstage(surveynr); j <= surveylastage(surveynr); j++) {
        if(ObsSurveyNr(surveynr,i,j) != -1) {
           SurveyResiduals(surveynr,i,j) = log( (ObsSurveyNr(surveynr,i,j)+SurveyResolution(surveynr,j))/
	  (CalcSurveyNr(surveynr,i,j)+SurveyResolution(surveynr,j)) );
          diff2 = square(SurveyResiduals(surveynr,i,j));
          v_hat = square(SigmaSurvey(surveynr,j));
          value += log(v_hat) - log((1-pcon)*exp(-diff2/(2*v_hat))+b/(1.+square(diff2/(square(e)*v_hat))));
        }
      }
    }
  }
  return value;
  




// Tuning with total biomass and proportion of biomass.  Not finished

FUNCTION dvariable Survey_loglikeli2(int surveynr)
  PredictSurveyAbundance1(surveynr); 
  dvariable value = 0;
  dvariable residual;
  dvariable surveybiosigma = 0.5;
  int i; 
  int j;  
  int finalyear =  min(lastoptyear+surveytimefromlastyear(surveynr),surveylastyear(surveynr));
  int minage = surveyfirstage(surveynr);
  int maxage =  surveylastage(surveynr);
  for(i = minage; i <= maxage; i++) 
    SigmaSurvey(surveynr,i) = SigmaSurveyInp(surveynr,i)*mfexp(SigmaSurveypar(surveynr));
  for( i = surveyfirstyear(surveynr); i <= finalyear; i++) {
     if(ObsSurveyBiomass(surveynr,i) != -1) {
        residual = log( ObsSurveyBiomass(surveynr,i)/CalcSurveyBiomass(surveynr,i));
        value += 0.5*square(residual/surveybiosigma) + log(surveybiosigma);
     }
  }
  dvar_vector obsproportion(minage,maxage);
  dvar_vector calcproportion(minage,maxage);

  for( i = surveyfirstyear(surveynr); i <= finalyear; i++) {
//      obsproportion = elem_prod(ObsSurveyBiomass(surveynr,i));
        residual = log( ObsSurveyBiomass(surveynr,i)/CalcSurveyBiomass(surveynr,i));
        value += 0.5*square(residual/surveybiosigma) + log(surveybiosigma);
  }
  return value;
 

FUNCTION dvariable SSB_Recruitment_loglikeli();

  // logSSBmax is in reality 5 times  the  spawing stock giving 1/2 maximum recruitment if Beverton 
  // and holt.  Therefore logSSBmax/5 in the relationship. SSB and SigmaSSBRec have already been predicted 
  // when this function is called.  
  dvariable value = 0;
// to avoid numerical problems in Ricker function.  Might be skipped for 
// other SSB-recruitment functions as it takes time.  
  dvariable Spawncorr= mfexp(estSSBRecParameters(4));
  dvariable minrecruitment = 1.0;
  dvariable maxrecruitment = 1.0e9;
  int i = 0;
  int j = 0;
  int lastestrecyear= lastoptyear-recrdatadelay;
  int nestrecyears = lastestrecyear-firstyear+1;
  dvar_vector tmpRecresid(1, nestrecyears);
  dvar_matrix Spawncorrmat(1, nestrecyears,1, nestrecyears);
  dvariable SpawnlnDet;
  for(i = firstyear; i <= lastestrecyear; i++){
      PredictedRecruitment(i) = SmoothDamper(PredictRecruitment(i),maxrecruitment,minrecruitment);
      RecruitmentResiduals(i) = log(Recruitment(i)/PredictedRecruitment(i));
      tmpRecresid(i-firstyear+1) =   RecruitmentResiduals(i);
  }
// Put in timeseries might be made faster if SigmaSSBrec is constant  
  for(i = 1; i <=  nestrecyears; i++) {
     Spawncorrmat(i,i) = 1.0*square(SigmaSSBRec(i+firstyear-1));
     for(j = 1; j < i; j++) {
        Spawncorrmat(i,j) = pow(Spawncorr,i-j)*SigmaSSBRec(i+firstyear-1)*SigmaSSBRec(j+firstyear-1);
	Spawncorrmat(j,i) = Spawncorrmat(i,j);
     }
  } 
  SpawnlnDet = log(det(Spawncorrmat));
  Spawncorrmat = inv(Spawncorrmat);
  value  = 0.5*(SpawnlnDet)+0.5*tmpRecresid*Spawncorrmat*tmpRecresid;
  return(value);


FUNCTION dvariable SSB_Recruitment_loglikeliNocorr();

  // logSSBmax is in reality 5 times  the  spawing stock giving 1/2 maximum recruitment if Beverton 
  // and holt.  Therefore logSSBmax/5 in the relationship. SSB and SigmaSSBRec have already been predicted 
  // when this function is called.  
  dvariable value = 0;
// to avoid numerical problems in Ricker function.  Might be skipped for 
// other SSB-recruitment functions as it takes time.  
  dvariable minrecruitment = 1.0;
  dvariable maxrecruitment = 1.0e9;
  int i = 0;
  int j = 0;
  for(i = firstyear; i <= lastoptyear-recrdatadelay; i++){
      PredictedRecruitment(i) = SmoothDamper(PredictRecruitment(i),maxrecruitment,minrecruitment);
      RecruitmentResiduals(i) = log(Recruitment(i)/PredictedRecruitment(i));
  }
// Put in timeseries effect later.  
  for(i = firstyear; i <= lastoptyear-recrdatadelay; i++) 
      value += log(SigmaSSBRec(i))+0.5*(square(RecruitmentResiduals(i)/SigmaSSBRec(i)));
   return(value);


// Function that predicts recruitment in a gven year from spawning stock or other variables.  
FUNCTION dvariable PredictRecruitment(int year)

   dvariable value;
   dvariable Rmax = mfexp(estSSBRecParameters(1));
   dvariable SSBmax = mfexp(estSSBRecParameters(2));
   if(SSBRectype == 1) {
        value = Rmax*mfexp(-TimeDrift(year))*Spawningstock(year)/
        (SSBmax/5.0+Spawningstock(year));
   }
   // Ricker.  Here logSSBmax exists.  
   if(SSBRectype == 2) {
       value = Rmax*mfexp(-TimeDrift(year))*mfexp(1.0)/SSBmax*Spawningstock(year)*mfexp(-Spawningstock(year)/SSBmax);
   } 

   // Ricker Eggproduction.  SSBmax er einhvers skonar Eggproduction maximum.  
   if(SSBRectype == 3) {
       value = Rmax*mfexp(-TimeDrift(year))*mfexp(1.0)/SSBmax*EggProduction(year)*mfexp(-EggProduction(year)/SSBmax);
   }   
   // Beverton and Holt Eggproduction.  
   if(SSBRectype == 4) {
     value = Rmax*mfexp(-TimeDrift(year))*EggProduction(year)/
        (SSBmax/5.0+EggProduction(year));    
   }   

// Segmented regression
   if(SSBRectype == 5) {
     value = Rmax*mfexp(-TimeDrift(year))*Spawningstock(year)/SSBmax;
     value = SmoothDamper(value,Rmax*mfexp(-TimeDrift(year)),0);
   }   

   
// Fixed mean 
   if(SSBRectype == 6) {
       value  = Rmax*mfexp(-TimeDrift(year));
   }
   return value;   

// Calculate fishing mortality from catch.  More complicated version needed for catch of 0 group.  
// except SSB is close to the beginning of the year.  

FUNCTION dvariable FishmortFromCatch(const dvariable C,const dvar_vector& Number,const dvar_vector& Wt,const dvar_vector& sel,const dvar_vector& M)
   int i;
   dvar_vector Biomass(firstage,lastage);
   dvariable Fishmort;
   Biomass = elem_prod(Number,Wt);
   dvariable Cbio;
   dvariable epsilon=0.0001;
   dvariable Catch,Catch1,dCatch;
   int age1 =  Number.indexmin();
   int age2 = Number.indexmax();
   dvar_vector tmpF(age1,age2);
   dvar_vector tmpZ(age1,age2);
   Cbio = sum(elem_prod(sel,elem_prod(Biomass,(mfexp(-M)))));
   Fishmort = C/Cbio+0.05; 
   Cbio = sum(elem_prod(sel,elem_prod(Biomass,(mfexp(-(M+Fishmort))))));
   Fishmort = C/Cbio+0.01; 

// Newtons method numeric differentiation 5 runs. 
   for(i = 1; i < 10; i++) {
      tmpF = Fishmort*sel;
      tmpZ = tmpF + M;
      Catch = sum(elem_prod(elem_prod(elem_div(tmpF,tmpZ),(1.-mfexp(-tmpZ))),Biomass));
      tmpF = (Fishmort+epsilon)*sel;
      tmpZ = tmpF + M;
      Catch1  = sum(elem_prod(elem_prod(elem_div(tmpF,tmpZ),(1.-mfexp(-tmpZ))),Biomass));
      dCatch = (Catch1-Catch)/epsilon;
      Fishmort = Fishmort - (Catch1-C)/dCatch;
   }
  return(Fishmort);




// *********************************************
// Reading of Catchfile.  
// Look if summation of plus group is nessecary.  
// Might want residual file as with the surveys.  
FUNCTION void ReadCatchandStockData()

  cifstream infile(catchfilename);
  if(infile.fail()) {
        cout << "File " << catchfilename << 
	"does not exist or something is wrong with it" << endl;
         exit(1);
   }
  ofstream outfile("catchfile.log");
  int i;
  int year;
  int age;
  dvariable ratio;
  dvector tmpvec(1,7);
  for(i = 1; i < largenumber; i++) {
     infile >> tmpvec;
     if(infile.eof()) break;
     year = int(tmpvec(1));
     age = int(tmpvec(2));
// Weights and maturity are changed from negative values (missing values) to 
// 0 .  Questionable.  
     if(year>= firstyear & year<= lastyear & age >= firstage & age <= lastage) {
     	ObsCatchInNumbers(year,age)  = tmpvec(3);
       	CatchWeightsData(year,age) = tmpvec(4);
        StockWeightsData(year,age) = tmpvec(5);
        StockMaturityData(year,age) = tmpvec(6);
        SSBWeightsData(year,age) = tmpvec(7);
        if(CatchWeightsData(year,age) < 0) CatchWeightsData(year,age) = 0;
        if(StockWeightsData(year,age) < 0) StockWeightsData(year,age) = 0;
        if(SSBWeightsData(year,age) < 0) SSBWeightsData(year,age) = 0;
        if(StockMaturityData(year,age) < 0) StockMaturityData(year,age) = 0;

       }
 // Add data if plus group. CNO used as proxy for stock in numbers in weighting data 
     if(year>= firstyear & year<= lastyear & age >  lastage & plusgroup == 1) {
	ratio = ObsCatchInNumbers(year,lastage)/(ObsCatchInNumbers(year,lastage)+tmpvec(3));
        ObsCatchInNumbers(year,lastage) += tmpvec(3);
 	CatchWeightsData(year,lastage) = CatchWeightsData(year,lastage)*ratio+tmpvec(4)*(1.0-ratio);
 	StockWeightsData(year,lastage) = StockWeightsData(year,lastage)*ratio+tmpvec(5)*(1.0-ratio);
 	StockMaturityData(year,lastage) = StockMaturityData(year,lastage)*ratio+tmpvec(6)*(1.0-ratio);
 	SSBWeightsData(year,lastage) = SSBWeightsData(year,lastage)*ratio+tmpvec(4)*(1.0-ratio);
      }
     outfile << tmpvec << endl;
  }
  outfile.close();
  infile.close();
// CatchWeights is the same as CatchWeightsData + possible random noise.  The same for other variables.  

  CatchWeights = CatchWeightsData;
  StockWeights = StockWeightsData;
  StockMaturity = StockMaturityData;
  SSBWeights = SSBWeightsData;

FUNCTION void ReadCatchParameters()
    cifstream infile(catchparametersfilename);
    ofstream outfile("catchparameters.log");
    int i;
    int j;
    dvector changeyears(1,number_of_seperable_periods+1);
    changeyears(1) = firstyear;
    changeyears(number_of_seperable_periods+1)= lastyear;
    if(number_of_seperable_periods > 1){
      outfile << "changeyears ";
      infile >> changeyears(2,number_of_seperable_periods);
      outfile << changeyears(2,number_of_seperable_periods);
    }
    // set separable periods.  
    parcolnr=1; 
    if(number_of_seperable_periods > 1){
      for(i = firstyear; i <= lastyear; i++) {
        for(j = 2; j <= number_of_seperable_periods; j++) 
           if(i > changeyears(j)) parcolnr(i) = j;
      }
    }
   cout << "parcolnr " << parcolnr << endl;
   infile >> ProcessError(firstage,lastage); 
// How much weight CNO gets relative to last years F.  
   outfile << "ProcessError " << ProcessError << endl;
   infile >> basfunc; 
   outfile << "basfunc" << endl << basfunc;


FUNCTION void ReadLikelihoodParameters()
   ofstream outfile("likelihood.log");
   cifstream infile(likelihoodparametersfilename);
   infile >> SigmaCinp(firstage,lastage);
   outfile  << "SigmaCinp " << SigmaCinp << endl;
   infile >> CatchResolution;
   outfile <<  "CatchResolution " << CatchResolution << endl;
   infile >>  sigmatotalcatch;
   outfile << "sigmatotalcatch " << sigmatotalcatch << endl;
   infile >>  CatchRobust;  // Robust log-likeli in catch
   infile >> SurveyRobust; // Robust log-likeli in survey
   outfile  << " CatchRobust " << CatchRobust << " SurveyRobust " << SurveyRobust << endl;
   infile >> Likeliweights(1,10); // Weights on likelhood comp, usually 1
   outfile << "Likeliweights " << Likeliweights << endl ;




FUNCTION void ReadStockParameters()
   ofstream outfile("stockparameters.log");
   cifstream infile(stockparametersfilename);
   infile >> Mdata(firstage,lastage);
   outfile  << "Mdata " << Mdata << endl;

   infile >>  PropofFbeforeSpawning; 
   infile >>  PropofMbeforeSpawning; 
   infile >>  minssbage;
   outfile << " PropofFbeforeSpawning " <<  PropofFbeforeSpawning << endl;
   outfile <<  " PropofMbeforeSpawning " <<  PropofMbeforeSpawning << endl;
   outfile << "minssbage " <<  minssbage << endl ;

   if(SSBRecParameters(5) > 0 | SSBRecSwitches(5) != -1) {
     infile >>  RefSSB >> Minrelssb >> Maxrelssb;
     outfile  << "RefSSB " << RefSSB << " Minrelssb " ;
     outfile << Minrelssb << "Maxrelssb " << Maxrelssb << endl;
  }
//***********************************************************************************************
// Migration years and ages.  The number of migrations has been input in main file
   if(MigrationNumbers > 0 ) {
     infile >>  MigrationYears;
     outfile  << "MigrationYears " << MigrationYears << endl ;
     infile >> MigrationAges;
     outfile  << "MigrationAges " << MigrationAges << endl ;
   }
   outfile.close();
   infile.close();


// --------------------------------------------
// Parameters to control the output from the program 

FUNCTION void ReadOutputParameters()
// Mean selection used for catchable biomass
   ofstream outfile("outputparameters.log");
   cifstream infile(outputparametersfilename);
   infile >> MeanSel(firstage,lastage);
   outfile  << "MeanSel" << endl << MeanSel << endl;
   infile >> Frefage1 >> Frefage2 >> WeightedF ; 
   outfile << "Frefage1 " << Frefage1 << "Frefage2 " << Frefage2 << endl;


//Sdreport values
FUNCTION void SetPredValues()  
  int i;
  PredRefF = RefF(lastoptyear-5,lastyear);
  PredSpawningstock = Spawningstock(lastoptyear-5,lastyear);
  for(i = lastoptyear-5; i <= lastyear; i++) PredN(i) = N(i,firstage);
  Survivors = N(lastoptyear+1);


// ***************************************************************
// Function that reads information about a survey  
//  

FUNCTION void ReadSurveyInfo(adstring parameterfilename,adstring datafilename, adstring residualfilename,int surveynumber,ofstream& surveylogfile)
  int ReadSurveyWeights = 0;
  int i;
  int year;
  int age;
  surveylogfile << endl << "Survey number " << endl; 
  cifstream parameterinfile(parameterfilename);

  int tmpminage;
  int tmpmaxage;
  dvariable tmpnumber;
  parameterinfile >> SurveyPropOfM(surveynumber);
  parameterinfile >> SurveyPropOfF(surveynumber);
  parameterinfile >> surveyweightsgiven(surveynumber);
  surveylogfile << "SurveyPropOfM " <<   SurveyPropOfM(surveynumber);
  surveylogfile << "SurveyPropOfF " <<   SurveyPropOfF(surveynumber);
  surveylogfile << "SurveyResolution " <<   SurveyResolution(surveynumber);
  surveylogfile << "surveyweightsgiven " << surveyweightsgiven(surveynumber)  << endl;
  
  parameterinfile >> tmpminage;
  parameterinfile >> tmpmaxage;

  surveylogfile << "tmpminage " << tmpminage << "tmpmaxage " << tmpmaxage << endl;
  surveylogfile << "CV as function of age" << endl;
  for(i = tmpminage; i <= tmpmaxage; i++) {
    parameterinfile >> tmpnumber;
    surveylogfile <<  tmpnumber << " "; 
    if(i >= firstage & i <= lastage) {
       SigmaSurveyInp(surveynumber,i) = tmpnumber;
    }
  }

  surveylogfile << "Resolution as function of age" << endl;
  for(i = tmpminage; i <= tmpmaxage; i++) {
    parameterinfile >> tmpnumber;
    surveylogfile <<  tmpnumber << " "; 
    if(i >= firstage & i <= lastage) {
       SurveyResolution(surveynumber,i) = tmpnumber;
    }
  }

  

  surveylogfile << endl;
  parameterinfile.close();
  cout << " start datafile" << endl;

// ath plus group in survey;
  int ncol;
  if(surveyweightsgiven(surveynumber) == 0) 
     ncol = 3;
  else 
     ncol = 4;
  dvector tmpvec(1,ncol);
  surveylogfile << "SurveyData " << endl;
  cifstream datainfile(datafilename);
  for( i = 1; i < largenumber; i++) {
     datainfile >> tmpvec;
     if(datainfile.eof()) break;
     year = int(tmpvec(1));
     age = int(tmpvec(2));
     if(year >= firstyear & year <= lastyear & age >= firstage & age <= lastage) {
     	ObsSurveyNr(surveynumber,year,age)  = tmpvec(3);
	if(surveyweightsgiven(surveynumber) != 0) SurveyWeights(surveynumber,year,age) = tmpvec(4);
        surveylogfile << tmpvec << endl;
     }
  }
  datainfile.close();

  dvector tmpvec1(1,3);
  surveylogfile << "Residuals " << endl;
  cifstream residualinfile(residualfilename);
  if(!residualinfile.fail()){
     for( i = 1; i < largenumber; i++) {
       residualinfile >> tmpvec1;
       if(residualinfile.eof()) break;
       year = int(tmpvec1(1));
       age = int(tmpvec1(2));
       ObsSurveyNr(surveynumber,year,age)  += tmpvec1(3);
       surveylogfile << tmpvec1 << endl;
     }
  }
  for(year = firstyear ; year <= lastyear; year++) {
     ObsSurveyBiomass(surveynumber,year) = sum(elem_prod(ObsSurveyNr(surveynumber,year),
	SurveyWeights(surveynumber,year)));
     ObsSurveyTotnr(surveynumber,year) = sum(ObsSurveyNr(surveynumber,year)); 
     if(ObsSurveyTotnr(surveynumber,year) == 0) {
	ObsSurveyNr(surveynumber,year) = -1;
	ObsSurveyTotnr(surveynumber,year) = -1;
	ObsSurveyBiomass(surveynumber,year) = -1;
    }
  }

//*****************************************************************************************
// Function that reads prognosisdata.  If no file is given the mean of last 3 years 
// is used.  
FUNCTION void ReadPrognosis()
   ofstream outfile("prognosis.log");
    int year;
    int age;
    int nCatchorFyrs;
    int i;
    dvar_vector ProgStockMaturity(firstage,lastage);
    dvar_vector ProgCatchWeights(firstage,lastage);
    dvar_vector ProgStockWeights(firstage,lastage);
    dvar_vector ProgSSBWeights(firstage,lastage);
    ProgStockMaturity =  ProgCatchWeights = ProgStockWeights = ProgSSBWeights = 0;
    cifstream infile(PrognosisFilename);
    infile >> PrintAll ;  // For later use if massive printing okt 2012 
    outfile << "PrintAll " << PrintAll << endl ; 

    infile >> CatchRule; // Number of catch rule.
    outfile << "Catchrule " << CatchRule << endl ;
    infile >> CurrentStockScaler; // Number of catch rule.
    outfile << "CurrentStockScaler " << CurrentStockScaler << endl ;
    infile >> weightcv; // cv of weights
    outfile << "weightcv" << weightcv << endl;
    infile >> weightcorr; // autocorrelations of weights
    outfile << "weightcorr" << weightcorr << endl;
    infile >> Assessmentcv; // cv of Assessments
    outfile << "Assessmentcv" << Assessmentcv << endl;
    infile >> Assessmentcorr; // autocorrelations of Assessments
    outfile << "Assessmentcorr" << Assessmentcorr << endl;
    infile >> CurrentAssessmentErrmultiplier;  // Multiplier on assessment error in current year.  Part is in the Hessian
    outfile << "CurrentAssessmentErrmultiplier " << CurrentAssessmentErrmultiplier << endl;  // Added Oct 2012
    infile >>  EstimatedAssYearRefBio; //Estimate of refbio in the assessment year to set first assessmenterr 
    outfile  << "EstimatedAssYearRefBio " << EstimatedAssYearRefBio << endl;
    infile >> Recrcorr; // autocorrelations of Recruitment cv estimated
    outfile << "Recrcorr" << Recrcorr << endl;
    infile >> nprogselyears;  // number of years to use for compiling selection in prognosis
    outfile  << "nprogselyears "<< nprogselyears << endl;
    infile >> nweightandmaturityselyears; // number of years to use for compiling weight and maturty in selection.  
    outfile <<  "nweightandmaturityselyears " << nweightandmaturityselyears << endl;
    if(nprogselyears==0) {
      infile >>  progsel ;  // Read prognosis selection
      outfile << "progsel " << progsel << endl;  
    }
    if(CatchRule == 1  || CatchRule == 2 || CatchRule == 4) { // F or Catch read next ncatch years, fill the rest with last value
        infile >> nCatchorFyrs;
        outfile << "nCatchorFyrs" << nCatchorFyrs << endl;
        if( nCatchorFyrs >  nsimuyears) cerr << "warning  nCathchorFyrs > nsimuyears)"; // Has to be the other way
        outfile << "FutureForCatch "; 
        for(i = lastoptyear+1; i <= lastoptyear+nCatchorFyrs; i++) {
          infile >> FutureForCatch(i); 
          outfile << FutureForCatch(i) << endl; 
        }
        if( nsimuyears > nCatchorFyrs) {
          for(i == lastoptyear+nCatchorFyrs; i <= lastoptyear+nsimuyears; i++) 
            FutureForCatch(i)=FutureForCatch(lastoptyear+nCatchorFyrs);  // Fill the rest) 
        }
    } 
    if(CatchRule == 2 || CatchRule == 3 || CatchRule == 5) {
      infile >> Btrigger ; 
      outfile << "Btrigger " << Btrigger << endl;
    }

    if(CatchRule == 3 || CatchRule == 5 ) {
      infile >>  RatioCurrentTac ; // Stabilizer
      outfile << "RatioCurrentTac " << RatioCurrentTac << endl;
      infile >>  RatioCurrentTacUnchangedBelowBtrigger ; // Stabilizer vs trigger
      outfile << "RatioCurrentTacUnchangedBelowBtrigger " << RatioCurrentTacUnchangedBelowBtrigger << endl;
      if( RatioCurrentTacUnchangedBelowBtrigger != 0 &&  RatioCurrentTacUnchangedBelowBtrigger != 1 &  RatioCurrentTacUnchangedBelowBtrigger != 2) 
           cout << "illegal value of  RatioCurrentTacUnchangedBelowBtrigger" << endl;

      if(CatchRule == 3 ) {
        infile >> HarvestRatio ; 
        outfile << "HarvestRatio " << HarvestRatio << endl;
      }
      if(CatchRule == 5 ) {
        infile >> Refbiobreak1  >> Refbiobreak2; 
        outfile << "Refbiobreak1 " << Refbiobreak1 << endl << "Refbiobreak2 " << Refbiobreak2 << endl ;
        infile >> HarvestRatio1  >> HarvestRatio2; 
        outfile << "HarvestRatio1 " << HarvestRatio1 << endl << "HarvestRatio2 " << HarvestRatio2 << endl ;
      }
      infile >> HCRrefage ; // biomass above HCRrefage
      outfile << "HCRrefage " << HCRrefage << endl; 
      infile >> UseStockWeights ;  // if 0 stockweights else catchweights
      outfile << "UseStockWeights " << UseStockWeights << endl;
      if(UseStockWeights != 0 && UseStockWeights != 1) 
        cout << "illegal value of UseStockWeights" << endl;
      infile >> CurrentTacInput ; 
      outfile << "CurrentTacInput " << CurrentTacInput << endl;
      infile >> TacLeftInput ; 
      outfile << "TacLeftInput " << TacLeftInput << endl;
      
   }   

   
   infile.close();
   cifstream  Progwtandmatinfile(WeightAndMaturityDatafilename);
   if(Progwtandmatinfile.fail()){
      cout << "No WeightAndMaturityDatafilename or bad prognosisfile use mean of last ** data years" << endl ;
      int usedlastdatayear = min(lastdatayear,lastyear);
      for(i = usedlastdatayear -nweightandmaturityselyears+1 ; i <= usedlastdatayear; i++) {
	ProgStockMaturity += StockMaturity(i);
	ProgCatchWeights += CatchWeights(i);
	ProgStockWeights += StockWeights(i);
	ProgSSBWeights += SSBWeights(i);
      }
      ProgStockMaturity/= nweightandmaturityselyears;
      ProgCatchWeights/= nweightandmaturityselyears;
      ProgStockWeights/= nweightandmaturityselyears;
      ProgSSBWeights/= nweightandmaturityselyears;
      cout << ProgStockMaturity << endl << ProgCatchWeights << endl << ProgStockWeights << endl;
      for(i = usedlastdatayear+1; i <= lastyear; i++) {
         StockMaturity(i) = ProgStockMaturity;
	 CatchWeights(i) = ProgCatchWeights;
         StockWeights(i) = ProgStockWeights;
         SSBWeights(i) = ProgSSBWeights;
         StockMaturityData(i) = ProgStockMaturity;
	 CatchWeightsData(i) = ProgCatchWeights;
         StockWeightsData(i) = ProgStockWeights;
         SSBWeightsData(i) = ProgSSBWeights;
      }
      return;
   }
   outfile << "StockAndMaturityData log " << endl;
   dvector tmpvec(1,6);
   for(i = 1; i <= largenumber ; i++) {
      Progwtandmatinfile >> tmpvec;
     if(infile.eof()) break;
      year = int(tmpvec(1));
      age = int(tmpvec(2));
      if(year >= lastdatayear & year <= lastyear & age >= firstage & age <= lastage) {
          CatchWeights(year,age) = tmpvec(3);
          StockWeights(year,age) = tmpvec(4);
          StockMaturity(year,age) = tmpvec(5);
          SSBWeights(year,age) = tmpvec(6);
     }
     outfile << tmpvec << endl;  
   }
   if( year < lastyear) {
      i = year;  
      for(year = i ; year <= lastyear ; year++) {
          CatchWeights(year) = CatchWeights(i);
          StockWeights(year) = StockWeights(i);
          StockMaturity(year) = StockMaturity(i);
          SSBWeights(year) = SSBWeights(i); 
      }
   }
   for(i = lastoptyear+1; i <= lastyear; i++) {
     StockMaturityData(i) = StockMaturity(i);
     CatchWeightsData(i) = CatchWeights(i);
     StockWeightsData(i) = StockWeights(i);
     SSBWeightsData(i) = SSBWeights(i);
   }
   Progwtandmatinfile.close();
   return; 
 //************************************************************************************************************
 //************************************************************************************************************
// Function that writes inputdata in tables.  
FUNCTION void WriteInputDataInMatrixForm()
   int i; 
   ofstream outfile("input1.log");
   dvector ages(firstage,lastage); 
   for(i = firstage; i<= lastage ; i++) ages[i] = i;

   outfile << "CatchInNumbers" << endl;
   outfile << "year\t" << ages << endl;
   for(i = firstyear; i <= lastyear; i++) 
      outfile << i << "\t" << ObsCatchInNumbers(i) << endl;

   outfile << endl <<  "CatchWeights" << endl;
   outfile << "year\t" << ages << endl;
   for(i = firstyear; i <= lastyear; i++) 
      outfile << i << "\t" << CatchWeights(i) << endl;

   outfile << endl <<  "StockWeights" << endl;
   outfile << "year\t" << ages << endl;
   for(i = firstyear; i <= lastyear; i++) 
      outfile << i << "\t" << StockWeights(i) << endl;

   outfile << endl <<  "SSBWeights" << endl;
   outfile << "year\t" << ages << endl;
   for(i = firstyear; i <= lastyear; i++) 
      outfile << i << "\t" << SSBWeights(i) << endl;

  
   outfile << endl <<  "StockMaturity" << endl;
   outfile << "year\t" << ages << endl;
   for(i = firstyear; i <= lastyear; i++) 
      outfile << i << "\t" << StockMaturity(i) << endl;
   outfile.close();


// Function to set stochasticity on weights and possibly maturity .
// Might later only be used for one year at time 
// it might sometime have to be related to stock size.  
// Other parameters like selection might also be included.
// Function is rather specific for the Icelandic cod.    

FUNCTION void UpdateWeightsAndMaturity() 
// Could est the starting point based on current value i.e negative


  random_number_generator r(COUNTER+10000);  // To avoid correlation
  dvar_vector weighterr(lastoptyear+1,lastyear);
  dvariable ratio = sqrt(1-weightcorr*weightcorr);
  int i;
  weighterr = 0; 
// mceval_phase does not work
  if(mceval_phase()|| mceval_phase()) {
    for(i = lastoptyear+1; i <= lastyear; i++)
      weighterr(i) = randn(r);
    weighterr(lastoptyear+1) = weighterr(lastoptyear+1)/ratio;
    for(i = lastoptyear+2; i <= lastyear; i++)
      weighterr(i) = weightcorr*weighterr(i-1)+weighterr(i);
    weighterr=weighterr*weightcv*ratio;
  }
  weighterr(lastoptyear+1)*=0.35;  // less weigth in first and second prediction
  weighterr(lastoptyear+2)*=0.7;
  for(i = lastoptyear+1; i <= lastyear; i++)
      CatchWeights(i) = mfexp(log(CatchWeightsData(i))+weighterr(i));
  for(i = lastoptyear+2; i <= lastyear; i++){ //SSB and Stock weights available in Assessyear
      StockWeights(i) = mfexp(log(StockWeightsData(i))+weighterr(i));
      SSBWeights(i) = mfexp(log(SSBWeightsData(i))+weighterr(i));
  }

// Function to set stochasticity on weights and possibly maturity .
// Sets white noise on each age and year.  

FUNCTION void UpdateWeightsAndMaturityWhiteNoise() 
// Could est the starting point based on current value i.e negative


  random_number_generator r(COUNTER+10000);  // To avoid correlation
  dvar_vector weighterr(firstage,lastage);
  int i;
  int j; 
  weighterr = 0; 
// mceval_phase does not work
  if(mceval_phase() || mceval_phase()) {    
    for(i = lastoptyear+1; i <= lastyear; i++){
      for(j=firstage; j <= lastage; j++) 
        weighterr(j) = randn(r)*weightcv;
      if(i == lastoptyear + 1 )
        CatchWeights(i) = mfexp(log(CatchWeightsData(i))+weighterr*0.35);
      if(i == lastoptyear + 2) {
         CatchWeights(i) = mfexp(log(CatchWeightsData(i))+weighterr*0.7);
         StockWeights(i) = mfexp(log(StockWeightsData(i))+weighterr*0.7);
         SSBWeights(i) = mfexp(log(SSBWeightsData(i))+weighterr*0.7);
      }
      if(i > lastoptyear + 2) { 
         CatchWeights(i) = mfexp(log(CatchWeightsData(i))+weighterr);
         StockWeights(i) = mfexp(log(StockWeightsData(i))+weighterr);
         SSBWeights(i) = mfexp(log(SSBWeightsData(i))+weighterr);
      }
    }
  }


// This function will be edited as needed.  The function is called on year by 
// year basis in prognosis but for all years in assessment.  The flag HistAssessment is 
// not used at the moment but might later be used.  

FUNCTION  void CalcRefValues(int firstyr,int lastyr,int HistAssessment) 
  int i;
  int j;

// Some variables that later might be input from file.  
  ivector RefBiominage(1,2);
  RefBiominage(1) = 4;  // For refbio1;
  RefBiominage(2) = 4;  // For refbio2;
  

  for(i = firstyr; i <= lastyr; i++) {
     N3(i) = N(i,3); 
     SWT6(i) = StockWeights(i,6);
     SWT3(i) = StockWeights(i,3);
     PredictSSB(i); 
     RefBio1(i) = sum(elem_prod(N(i)(RefBiominage(1),lastage),
	StockWeights(i)(RefBiominage(1),lastage)))/1.0e6;
    RefBio2(i) = sum(elem_prod(N(i)(RefBiominage(2),lastage),
	CatchWeights(i)(RefBiominage(2),lastage)))/1.0e6;
    CbioR(i) = 0; 
    for(j = firstage; j <= lastage; j++) 
     CbioR(i)  = CbioR(i) + N(i,j)*CatchWeights(i,j)*MeanSel(j)*(1-mfexp(-Z(i,j)))/Z(i,j);
    RefF(i) = CalcMeanF(F(i));
    CbioR(i)/= 1.0e6;
   }

   RelSpawningstock = Spawningstock/Spawningstock(lastoptyear+1);  // Ministers question
   RelSpawningstock(lastoptyear+1) +=   RelSpawningstock(lastoptyear)/1e6;  // To avoind error message

  if(HistAssessment == 1) {
    if(nprogselyears > 0) {  // calculate progsel if it is not read from file.  
       for(j = firstcatchage; j <= lastage; j++) {
         progsel(j) = 0;
         for(i = lastoptyear-nprogselyears+1; i <= lastoptyear; i++)  
           progsel(j)  += F(i,j)/RefF(i); 
       }
       progsel /= nprogselyears;
    }
    for(j = firstcatchage; j <= lastage; j++) {
      meansel(j) = 0;
       for(i = firstyear; i <= lastoptyear; i++)  
        meansel(j)  += F(i,j)/RefF(i);
    } 
    meansel /= noptyears;
  }


// Predict SSB for a given year.  Also the CV in SSB-Recruitment relationship.  

FUNCTION void PredictSSB(int year)
   int age;
   dvariable Eggratio;
   dvariable SSBRecCV = mfexp(estSSBRecParameters(3));
   dvariable SSBRecpow = estSSBRecParameters(5);
    Spawningstock(year) = 0;
   for(age = minssbage; age <= lastage; age++){
     Spawningstock(year) += N(year,age)*SSBWeights(year,age)*StockMaturity(year,age)*
     mfexp(-(natM(year,age)*PropofMbeforeSpawning(age)+F(year,age)*PropofFbeforeSpawning(age)));
     Eggratio = 0.01+0.09*SSBWeights(year,age)/20000;
     Eggratio = SmoothDamper(Eggratio,0.1,0);
     EggProduction(year) += Eggratio*N(year,age)*SSBWeights(year,age)*StockMaturity(year,age)*
     mfexp(-(natM(year,age)*PropofMbeforeSpawning(age)+F(year,age)*PropofFbeforeSpawning(age)));
   }
   Totbio(year) = sum(elem_prod(SSBWeights(year),N(year)))/1e6;
   Spawningstock(year)/= 1e6; 
   EggProduction(year)/= 1e6;  
   SigmaSSBRec(year) = SSBRecCV/pow(SmoothDamper(Spawningstock(year)/
   RefSSB,Maxrelssb,Minrelssb),SSBRecpow);
 
//  Smooth Roof and Floor.  
FUNCTION dvariable  SmoothDamper(dvariable x, dvariable Roof,dvariable Floor) 
  dvariable deltax = 0.01;
  if(Roof == Floor) return(x); 
  dvariable lb = 1.0 - deltax/2.0;
  dvariable ub = 1.0 + deltax/2.0;
  if(x <= lb* Roof && x >= ub*Floor) return x;
  if(x >= ub*Roof) return Roof;
  if(x <= lb*Floor) return Floor;
  if(x <= ub*Roof && x >= lb*Roof) {
    dvariable y = (x - ub*Roof);
    return Roof - 0.5/deltax/Roof*y*y;
  }
  if(x >= lb*Floor && x <= ub*Floor) {
    dvariable  y = (x - lb*Floor);
    return Floor +0.5/deltax/Floor*y*y;
  }




// Seperable nonparametric function Hardwire same selction for the 
// last 3 age groups  (


// Lastage -2 should not be hardwired.  

FUNCTION void CalcFishingMortality1a(int year) 
   int age;
   for(age = firstcatchage; age <=  lastage-3; age++) 
       F(year,age) = mfexp(lnMeanEffort+lnEffort(year)+InitialSelection(age));
   for(age = lastage-2; age <=  lastage; age++) 
       F(year,age) = mfexp(lnMeanEffort+lnEffort(year)+InitialSelection(lastage-2));


// Number of Separable periods.  
// Lastage -3 should not be hardwired.  
FUNCTION void CalcFishingMortality1b(int year) 
   
   int age;
   for(age = firstcatchage; age <=  lastage-4; age++) 
       F(year,age) = mfexp(lnMeanEffort+lnEffort(year)+EstimatedSelection(age,parcolnr(year)));
   for(age = lastage-3; age <=  lastage; age++) 
       F(year,age) = mfexp(lnMeanEffort+lnEffort(year));





FUNCTION dvariable CalcMeanF(dvar_vector Fm)
  return mean(Fm(Frefage1,Frefage2));

FUNCTION void write_mcmc()
  // Writes MCMC chains to many wide-format files
  // Each quantity gets one column and all files have the same number of lines
  // Strict format: no space before first column, one space between columns, and no space after last column
  // Would be nice to change to increase flexibility in printing out.  
  RefBioHCR =  RefBioHCR/1.0e6;
  RefBioHCRwitherr =  RefBioHCRwitherr/1.0e6;
  FishingYearTac = FishingYearTac/1.0e6;

  // 1 Likelihood components
  if(likelihood_mcmc_lines == 0)
  {
    likelihood_mcmc<<"LnLikely";
    for(int i=1; i<=size_count(LnLikelicomp); i++)
      likelihood_mcmc<<" LnLikelicomp."<<i;
    likelihood_mcmc<<endl;
  }
  likelihood_mcmc<<LnLikely<<LnLikelicomp<<endl;
  likelihood_mcmc_lines++;

//  // 2 Migrations from Greenland
//  if(size_count(lnMigrationAbundance) > 0)
//  {
//    if(migration_mcmc_lines == 0)
//    {
//      migration_mcmc<<"MigrationAbundance."<<MigrationYears(1);
//      for(int i=2; i<=size_count(lnMigrationAbundance); i++)
//        migration_mcmc<<" MigrationAbundance."<<MigrationYears(i);
//      migration_mcmc<<endl;
//    }
//    migration_mcmc<<mfexp(lnMigrationAbundance(1));
//    migration_mcmc<<mfexp(lnMigrationAbundance.sub(2,size_count(lnMigrationAbundance)))<<endl;
//    migration_mcmc_lines++;
//  }

  // 3 Historical recruitment
  if(recruitment_mcmc_lines == 0)
  {
    recruitment_mcmc<<"Recr."<<lnRecr.indexmin();
    for(int t=lnRecr.indexmin()+1; t<=lnRecr.indexmax(); t++)
      recruitment_mcmc<<" lnRecr."<<t;
    recruitment_mcmc<<endl;
  }
  recruitment_mcmc<<mfexp(lnMeanRecr+lnRecr(lnRecr.indexmin()));
  recruitment_mcmc<<mfexp(lnMeanRecr+lnRecr.sub(lnRecr.indexmin()+1,lnRecr.indexmax()))<<endl;
  recruitment_mcmc_lines++;

  // 4 Initial population
  if(initpopulation_mcmc_lines == 0)
  {
    initpopulation_mcmc<<"Initialpop."<<lnInitialpop.indexmin();
    for(int a=lnInitialpop.indexmin()+1; a<=lnInitialpop.indexmax(); a++)
      initpopulation_mcmc<<" Initialpop."<<a;
    initpopulation_mcmc<<endl;
  }
  initpopulation_mcmc<<mfexp(lnMeanInitialpop+lnInitialpop(lnInitialpop.indexmin()));
  initpopulation_mcmc<<mfexp(lnMeanInitialpop+lnInitialpop.sub(lnInitialpop.indexmin()+1,lnInitialpop.indexmax()))<<endl;
  initpopulation_mcmc_lines++;


  // 4 Assessmentyearpopulation
  if(assessmentyearpopulation_mcmc_lines == 0)
  {
    assessmentyearpopulation_mcmc<<"Assessmentyearpop." << firstage;
    for(int a=firstage+1; a<=lastage; a++)
      assessmentyearpopulation_mcmc<<" Assessmentyeariapop."<<a;
    assessmentyearpopulation_mcmc<<endl;
  }
  assessmentyearpopulation_mcmc<< N(lastoptyear+1) << endl;
  assessmentyearpopulation_mcmc_lines++;

 
   // 5 Eestimated selection
//  if(estimatedselection_mcmc_lines == 0)
//  {
 //   estimatedselection_mcmc<<"EstimatedSelection."<<EstimatedSelection.colmin();
 //   for(int a=EstimatedSelection.colmin()+1; a<=EstimatedSelection.colmax(); a++)
 //     estimatedselection_mcmc<<" EstimatedSelection.1."<<a;
 //   for(int i=EstimatedSelection.rowmin(); i<=EstimatedSelection.rowmax(); i++)
 //     for(int a=EstimatedSelection.colmin(); a<=EstimatedSelection.colmax(); a++)
 //       estimatedselection_mcmc<<" EstimatedSelection."<<i<<"."<<a;
 //   estimatedselection_mcmc<<endl;
 // }
 // estimatedselection_mcmc<<EstimatedSelection(1,EstimatedSelection.colmin());
 // estimatedselection_mcmc<<row(EstimatedSelection,1).sub(EstimatedSelection.colmin()+1,EstimatedSelection.colmax());
 // for(int i=2; i<=EstimatedSelection.rowsize(); i++)
 //   estimatedselection_mcmc<<row(EstimatedSelection,i);
 // estimatedselection_mcmc<<endl;
 // estimatedselection_mcmc_lines++;


  // 6 Parameters that are not age- or year-specific vectors
  if(parameter_mcmc_lines == 0)
  {
    parameter_mcmc<<"MeanRecr MeanInitialpop Catchlogitslope Catchlogitage50 SigmaCmultiplier AbundanceMultiplier MeanEffort";
    for(int i=1; i<=size_count(estSSBRecParameters); i++)
      parameter_mcmc<<" estSSBRecParameters."<<i;
    parameter_mcmc<<endl;
  }
  parameter_mcmc<<mfexp(lnMeanRecr)<<" "<<mfexp(lnMeanInitialpop)<<" "<<Catchlogitslope<<" "<<Catchlogitage50<<" "<<mfexp(logSigmaCmultiplier)<<" "<<AbundanceMultiplier<<" "<<mfexp(lnMeanEffort)<<estSSBRecParameters<<endl;
  parameter_mcmc_lines++;

  // 7 Survey catchability power coefficients
//  if(size_count(SurveyPowerest) > 0)
//  {
//   if(surveypower_mcmc_lines == 0)
//   {
//      surveypower_mcmc<<"SurveyPowerest.1."<<SurveyPowerest.colmin();
//      for(int a=SurveyPowerest.colmin()+1; a<=SurveyPowerest.colmax(); a++)
//        surveypower_mcmc<<" SurveyPowerest.1."<<a;
//      for(int i=2; i<=SurveyPowerest.rowsize(); i++)
//        for(int a=SurveyPowerest.colmin(); a<=SurveyPowerest.colmax(); a++)
//          surveypower_mcmc<<" SurveyPowerest."<<i<<"."<<a;
//      surveypower_mcmc<<endl;
//    }
//    surveypower_mcmc<<SurveyPowerest(1,SurveyPowerest.colmin());
//    surveypower_mcmc<<row(SurveyPowerest,1).sub(SurveyPowerest.colmin()+1,SurveyPowerest.colmax());
//    for(int i=2; i<=SurveyPowerest.rowsize(); i++)
//      surveypower_mcmc<<row(SurveyPowerest,i);
//    surveypower_mcmc<<endl;
//    surveypower_mcmc_lines++;
//  }

  // 8 Survey catchability 
  if(surveyq_mcmc_lines == 0)
  {
    surveyq_mcmc<<"SurveylnQest.1."<<SurveylnQest.colmin();
    for(int a=SurveylnQest.colmin()+1; a<=SurveylnQest.colmax(); a++)
      surveyq_mcmc<<" SurveylnQest.1."<<a;
    for(int i=2; i<=SurveylnQest.rowsize(); i++)
      for(int a=SurveylnQest.colmin(); a<=SurveylnQest.colmax(); a++)
        surveyq_mcmc<<" SurveylnQest."<<i<<"."<<a;
    surveyq_mcmc<<endl;
  }
  surveyq_mcmc<<SurveylnQest(1,SurveylnQest.colmin());
  surveyq_mcmc<<row(SurveylnQest,1).sub(SurveylnQest.colmin()+1,SurveylnQest.colmax());
  for(int i=2; i<=SurveylnQest.rowsize(); i++)
    surveyq_mcmc<<row(SurveylnQest,i);
  surveyq_mcmc<<endl;
  surveyq_mcmc_lines++;

  // 9 Effort
  if(effort_mcmc_lines == 0)
  {
    effort_mcmc<<"Effort."<<lnEffort.indexmin();
    for(int t=lnEffort.indexmin()+1; t<=lnEffort.indexmax(); t++)
      effort_mcmc<<" Effort."<<t;
    effort_mcmc<<endl;
  }
  effort_mcmc<<mfexp(lnMeanEffort+lnEffort(lnEffort.indexmin()));
  effort_mcmc<<mfexp(lnMeanEffort+lnEffort.sub(lnEffort.indexmin()+1,lnEffort.indexmax()))<<endl;
  effort_mcmc_lines++;

  // 10 Catch
  if(catch_mcmc_lines == 0)
  {
    catch_mcmc<<"CalcCatchIn1000tons."<<CalcCatchIn1000tons.indexmin();
    for(int t=CalcCatchIn1000tons.indexmin()+1; t<=CalcCatchIn1000tons.indexmax(); t++)
      catch_mcmc<<" CalcCatchIn1000tons."<<t;
    catch_mcmc<<endl;
  }
  catch_mcmc<<CalcCatchIn1000tons(CalcCatchIn1000tons.indexmin());
  catch_mcmc<<CalcCatchIn1000tons.sub(CalcCatchIn1000tons.indexmin()+1,CalcCatchIn1000tons.indexmax())<<endl;
  catch_mcmc_lines++;

  // 11 Reference biomass
  if(refbio_mcmc_lines == 0)
  {
    refbio_mcmc<<"RefBio2."<<RefBio2.indexmin();
    for(int t=RefBio2.indexmin()+1; t<=RefBio2.indexmax(); t++)
      refbio_mcmc<<" RefBio2."<<t;
    refbio_mcmc<<endl;
  }
  refbio_mcmc<<RefBio2(RefBio2.indexmin());
  refbio_mcmc<<RefBio2.sub(RefBio2.indexmin()+1,RefBio2.indexmax())<<endl;
  refbio_mcmc_lines++;



  // 12 N3  

  if(n3_mcmc_lines == 0)
  {
    n3_mcmc<<"N3."<<N3.indexmin();
    for(int t=N3.indexmin()+1; t<=N3.indexmax(); t++)
      n3_mcmc<<" N3."<<t;
    n3_mcmc<<endl;
  }
  n3_mcmc<<N3(N3.indexmin());
  n3_mcmc<<N3.sub(N3.indexmin()+1,N3.indexmax())<<endl;
  n3_mcmc_lines++;

  // 13 Reference F
  if(f_mcmc_lines == 0)
  {
    f_mcmc<<"RefF."<<RefF.indexmin();
    for(int t=RefF.indexmin()+1; t<=RefF.indexmax(); t++)
      f_mcmc<<" RefF."<<t;
    f_mcmc<<endl;
  }
  f_mcmc<<RefF(RefF.indexmin());
  f_mcmc<<RefF.sub(RefF.indexmin()+1,RefF.indexmax())<<endl;
  f_mcmc_lines++;

  // 14 Spawning stock biomass
  if(ssb_mcmc_lines == 0)
  {
    ssb_mcmc<<"Spawningstock."<<Spawningstock.indexmin();
    for(int t=Spawningstock.indexmin()+1; t<=Spawningstock.indexmax(); t++)
    ssb_mcmc<<" Spawningstock."<<t;
    ssb_mcmc<<endl;
  }
  ssb_mcmc<<Spawningstock(Spawningstock.indexmin());
  ssb_mcmc<<Spawningstock.sub(Spawningstock.indexmin()+1,Spawningstock.indexmax())<<endl;
  ssb_mcmc_lines++;

  if(relssb_mcmc_lines == 0)
  {
    relssb_mcmc<<"RelSpawningstock."<<RelSpawningstock.indexmin();
    for(int t=RelSpawningstock.indexmin()+1; t<=RelSpawningstock.indexmax(); t++)
      relssb_mcmc<<" RelSpawningstock."<<t;
    relssb_mcmc<<endl;
  }
  relssb_mcmc<<RelSpawningstock(RelSpawningstock.indexmin());
  relssb_mcmc<<RelSpawningstock.sub(RelSpawningstock.indexmin()+1,RelSpawningstock.indexmax())<<endl;
  relssb_mcmc_lines++;


// HCR refbio.  
  if(refbiohcr_mcmc_lines == 0)
  {
    refbiohcr_mcmc<<"RefBioHCR."<<RefBioHCR.indexmin();
    for(int t=RefBioHCR.indexmin()+1; t<=RefBioHCR.indexmax(); t++)
      refbiohcr_mcmc<<" RefBioHCR."<<t;
    refbiohcr_mcmc<<endl;
  }
  refbiohcr_mcmc<<RefBioHCR(RefBioHCR.indexmin());
  refbiohcr_mcmc<<RefBioHCR.sub(RefBioHCR.indexmin()+1,RefBioHCR.indexmax())<<endl;
  refbiohcr_mcmc_lines++;

  if(refbiohcrwitherr_mcmc_lines == 0)
  {
    refbiohcrwitherr_mcmc<<"RefBioHCRwitherr."<<RefBioHCRwitherr.indexmin();
    for(int t=RefBioHCRwitherr.indexmin()+1; t<=RefBioHCRwitherr.indexmax(); t++)
      refbiohcrwitherr_mcmc<<" RefBioHCRwitherr."<<t;
    refbiohcrwitherr_mcmc<<endl;
  }
  refbiohcrwitherr_mcmc<<RefBioHCRwitherr(RefBioHCRwitherr.indexmin());
  refbiohcrwitherr_mcmc<<RefBioHCRwitherr.sub(RefBioHCRwitherr.indexmin()+1,RefBioHCRwitherr.indexmax())<<endl;
  refbiohcrwitherr_mcmc_lines++;


  if(ssbwitherr_mcmc_lines == 0)
  {
    ssbwitherr_mcmc<<"SSBwitherr."<<SSBwitherr.indexmin();
    for(int t=SSBwitherr.indexmin()+1; t<=SSBwitherr.indexmax(); t++)
      ssbwitherr_mcmc<<" SSBwitherr."<<t;
    ssbwitherr_mcmc<<endl;
  }
  ssbwitherr_mcmc<<SSBwitherr(SSBwitherr.indexmin());
  ssbwitherr_mcmc<<SSBwitherr.sub(SSBwitherr.indexmin()+1,SSBwitherr.indexmax())<<endl;
  ssbwitherr_mcmc_lines++;

  if(fishingyeartac_mcmc_lines == 0)
  {
    fishingyeartac_mcmc<<"FishingYearTac."<<FishingYearTac.indexmin();
    for(int t=FishingYearTac.indexmin()+1; t<=FishingYearTac.indexmax(); t++)
      fishingyeartac_mcmc<<" FishingYearTac."<<t;
    fishingyeartac_mcmc<<endl;
  }
  fishingyeartac_mcmc<<FishingYearTac(FishingYearTac.indexmin());
  fishingyeartac_mcmc<<FishingYearTac.sub(FishingYearTac.indexmin()+1,FishingYearTac.indexmax())<<endl;
  fishingyeartac_mcmc_lines++;

  if(assessmenterror_mcmc_lines == 0)
  {
    assessmenterror_mcmc<<"AssessmentErr."<<AssessmentErr.indexmin();
    for(int t=AssessmentErr.indexmin()+1; t<=AssessmentErr.indexmax(); t++)
      assessmenterror_mcmc<<" AssessmentErr."<<t;
    assessmenterror_mcmc<<endl;
  }
  assessmenterror_mcmc<<AssessmentErr(AssessmentErr.indexmin());
  assessmenterror_mcmc<<AssessmentErr.sub(AssessmentErr.indexmin()+1,AssessmentErr.indexmax())<<endl;
  assessmenterror_mcmc_lines++;


// SWT6

  if(swt3_mcmc_lines == 0)
  {
    swt3_mcmc<<"SWT3."<<SWT3.indexmin();
    for(int t=SWT3.indexmin()+1; t<=SWT3.indexmax(); t++)
      swt3_mcmc<<" SWT3."<<t;
    swt3_mcmc<<endl;
  }
  swt3_mcmc<<SWT3(SWT3.indexmin());
  swt3_mcmc<<SWT3.sub(SWT3.indexmin()+1,SWT3.indexmax())<<endl;
  swt3_mcmc_lines++;

  if(swt6_mcmc_lines == 0)
  {
    swt6_mcmc<<"SWT6."<<SWT6.indexmin();
    for(int t=SWT6.indexmin()+1; t<=SWT6.indexmax(); t++)
      swt6_mcmc<<" SWT6."<<t;
    swt6_mcmc<<endl;
  }
  swt6_mcmc<<SWT6(SWT6.indexmin());
  swt6_mcmc<<SWT6.sub(SWT6.indexmin()+1,SWT6.indexmax())<<endl;
  swt6_mcmc_lines++;

//ssbrecparameters
  ssbrec_mcmc << estSSBRecParameters << endl;
  ssbrec_mcmc_lines++;


  // Fishable biomass

  if(cbior_mcmc_lines == 0)
  {
    cbior_mcmc<<"CbioR."<<CbioR.indexmin();
    for(int t=CbioR.indexmin()+1; t<=CbioR.indexmax(); t++)
      cbior_mcmc<<" CbioR."<<t;
    cbior_mcmc<<endl;
  }
  cbior_mcmc<<CbioR(CbioR.indexmin());
  cbior_mcmc<<CbioR.sub(CbioR.indexmin()+1,CbioR.indexmax())<<endl;
  cbior_mcmc_lines++;


// finalpopulation.  
  if(finalpopulation_mcmc_lines == 0)
  {
    finalpopulation_mcmc<<"Finalpopulation."<<Finalpopulation.indexmin();
    for(int t=Finalpopulation.indexmin()+1; t<=Finalpopulation.indexmax(); t++)
      finalpopulation_mcmc<<" Finalpopulation."<<t;
    finalpopulation_mcmc<<endl;
  }
  finalpopulation_mcmc<<Finalpopulation(Finalpopulation.indexmin());
  finalpopulation_mcmc<<Finalpopulation.sub(Finalpopulation.indexmin()+1,Finalpopulation.indexmax())<<endl;
  finalpopulation_mcmc_lines++;


// Not used very much . Different form of printing compared to write_mcmc
FUNCTION void write_mcmc_long()
  // Writes MCMC chains to a few long-format files
  // Each file has at least three columns (i, Quantity, Value)
  // Section numbers correspond to write_mcmc

  if(mcmc_iteration == 1)
  {
    chains_like<<"i Quantity Value"<<endl;
    chains_par<<"i Quantity Value"<<endl;
    chains_age<<"i Quantity Age Value"<<endl;
    chains_year<<"i Quantity Year Value"<<endl;
  }

  // LIKELIHOODS
  // 1 Likelihood components
  chains_like<<mcmc_iteration<<" LnLikely "<<LnLikely<<endl;
  for(int i=1; i<=size_count(LnLikelicomp); i++)
    chains_like<<mcmc_iteration<<" LnLikelicomp."<<i<<" "<<LnLikelicomp(i)<<endl;

  // PARAMETERS THAT ARE NEITHER AGE- NOR YEAR- SPECIFIC VECTORS
  // 6 Parameters that are not age- or year-specific vectors
  chains_par<<mcmc_iteration<<" MeanRecr "<<mfexp(lnMeanRecr)<<endl;
  chains_par<<mcmc_iteration<<" MeanInitialpop "<<mfexp(lnMeanInitialpop)<<endl;
  chains_par<<mcmc_iteration<<" Catchlogitslope "<<Catchlogitslope<<endl;
  chains_par<<mcmc_iteration<<" Catchlogitage50 "<<Catchlogitage50<<endl;
  chains_par<<mcmc_iteration<<" SigmaCmultiplier "<<mfexp(logSigmaCmultiplier)<<endl;
  chains_par<<mcmc_iteration<<" AbundanceMultiplier "<<AbundanceMultiplier<<endl;
  chains_par<<mcmc_iteration<<" lnMeanEffort "<<mfexp(lnMeanEffort)<<endl;

  // AGE
  // 4 Initial population
  for(int a=lnInitialpop.indexmin(); a<=lnInitialpop.indexmax(); a++)
    chains_age<<mcmc_iteration<<" Initialpop "<<a<<" "<<mfexp(lnMeanInitialpop+lnInitialpop(a))<<endl;
  // 5 Estimated selection
  for(int i=EstimatedSelection.rowmin(); i<=EstimatedSelection.rowmax(); i++)
    for(int a=EstimatedSelection.colmin(); a<=EstimatedSelection.colmax(); a++)
      chains_age<<mcmc_iteration<<" EstimatedSelection."<<i<<" "<<a<<" "<<EstimatedSelection(i,a)<<endl;
  // 7 Survey catchability power coefficients
  for(int i=1; i<=SurveyPowerest.rowsize(); i++)
    for(int a=SurveyPowerest.colmin(); a<=SurveyPowerest.colmax(); a++)
      chains_age<<mcmc_iteration<<" SurveyPowerest."<<i<<" "<<a<<" "<<SurveyPowerest(i,a)<<endl;
  // 8 Survey catchability

  
  for(int i=1; i<=SurveylnQest.rowsize(); i++)
    for(int a=SurveylnQest.colmin(); a<=SurveylnQest.colmax(); a++)
      chains_age<<mcmc_iteration<<" SurveylnQest."<<i<<" "<<a<<" "<<SurveylnQest(i,a)<<endl;

  // YEAR
  // 2 Migrations from Greenland
  for(int i=1; i<=size_count(lnMigrationAbundance); i++)
    chains_year<<mcmc_iteration<<" MigrationAbundance "<<MigrationYears(i)<<" "<<mfexp(lnMigrationAbundance(i))<<endl;
  // 3 Historical recruitment
  for(int t=lnRecr.indexmin(); t<=lnRecr.indexmax(); t++)
    chains_year<<mcmc_iteration<<" Recr "<<t<<" "<<mfexp(lnRecr(t))<<endl;
  // 9 Effort
  for(int t=lnEffort.indexmin(); t<=lnEffort.indexmax(); t++)
    chains_year<<mcmc_iteration<<" Effort "<<t<<" "<<mfexp(lnEffort(t))<<endl;
  // 10 Catch
  for(int t=CalcCatchIn1000tons.indexmin(); t<=CalcCatchIn1000tons.indexmax(); t++)
    chains_year<<mcmc_iteration<<" CalcCatchIn1000tons "<<t<<" "<<CalcCatchIn1000tons(t)<<endl;
  // 11 Reference biomass
  for(int t=RefBio2.indexmin(); t<=RefBio2.indexmax(); t++)
    chains_year<<mcmc_iteration<<" RefBio2 "<<t<<" "<<RefBio2(t)<<endl;
  // 12 N3
  for(int t=N3.indexmin(); t<=N3.indexmax(); t++)
    chains_year<<mcmc_iteration<<" N3 "<<t<<" "<<N3(t)<<endl;
  // 13 Reference F
  for(int t=RefF.indexmin(); t<=RefF.indexmax(); t++)
    chains_year<<mcmc_iteration<<" RefF "<<t<<" "<<RefF(t)<<endl;
  // 14 Spawning stock biomass
  for(int t=Spawningstock.indexmin(); t<=Spawningstock.indexmax(); t++)
    chains_year<<mcmc_iteration<<" Spawningstock "<<t<<" "<<Spawningstock(t)<<endl;
  for(int t=RelSpawningstock.indexmin(); t<=RelSpawningstock.indexmax(); t++)
    chains_year<<mcmc_iteration<<" RelSpawningstock "<<t<<" "<<RelSpawningstock(t)<<endl;

  mcmc_iteration++;


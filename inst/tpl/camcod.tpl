// Changes to model in april 2007 add SSB by age.  
DATA_SECTION
// Reading module. 
  int debug_input_flag
  !! debug_input_flag=1;
  !! ofstream ofs("input.log");
  init_int firstyear    // firstyear used in the assesment
  init_int lastyear;	// Last year used in the assessment
  init_int firstdatayear // First year with catch data 
  init_int lastdatayear // First year with catch data 
  !! 
  init_int firstage 	// First age
  init_int nsimuyrs	// Number of years simulated
  init_int nages	// Number of age groups
  init_int firstcatchage	// First age group in catch
  init_int PlusGroup;  // Is last age group + group 1 not 0
  int a1  // firstcatchage-firstage+1
  !!a1 = firstcatchage-firstage+1;
  int nyrs;
  !!nyrs = lastyear - firstyear + 1;
  int ndatayrs;
  !!ndatayrs = lastdatayear - firstdatayear + 1;
  !! ofs << " lastyear " << lastyear << " firstyear " << firstyear; 
  !! ofs << " firstdatayear " << firstdatayear << " lastdatayear " << lastdatayear ; 
  !! ofs  << " firstage " << firstage << endl ;
  !! ofs << " ndatayrs " << ndatayrs << " nsimuyrs " << nsimuyrs << " nages " << nages ;
  !! ofs << " firstcatchage " << firstcatchage << "a1 " << a1;
  !! ofs << " PlusGroup " << PlusGroup << endl;

  init_matrix ObsCatchInNumbersData(1,ndatayrs,a1,nages) // catch in numbers
  !! ofs << "ObsCatchInNumbersData " << endl << ObsCatchInNumbersData << endl;

// Weights in catch  The value for ndatayrs+2 is used in simulations
  init_matrix CatchWtsData(1,ndatayrs+2,a1,nages)
  !! ofs << "CatchWtsData "<< endl  << CatchWtsData << endl;
 
// Weights in spawning stock. The value for ndatayrs+2 is used in simulations
  init_matrix ssbWtsData(1,ndatayrs+2,a1,nages)
  !! ofs << "ssbWtsData " << ssbWtsData << endl; 

// Maturity at age.   The value for ndatayrs+2 is used in simulations
  init_matrix CatchSexMatData(1,ndatayrs+2,a1,nages)
  !! ofs << "CatchSexMatData " << CatchSexMatData << endl;

  init_matrix StockSexMatData(1,ndatayrs+2,a1,nages)
  !! ofs << "StockSexMatData " << StockSexMatData << endl;

//  Weights in stock. The value for ndatayrs+2 is used in simulations
// Have to be listed for all age groups, not only those in the catch.  

  init_matrix StockWtsData(1,ndatayrs+2,1,nages);
  !! ofs << "StockWtsData" << endl << StockWtsData << endl;

// Natural mortality by age:
  init_vector M1(1,nages) 
  !! ofs << "M" << endl << M1 << endl;

// Mean selection used for catchable biomass
  init_vector MeanSel(a1,nages);
  !! ofs << "MeanSel" << endl << MeanSel << endl;

// Survey data.  (Assumed to be at the beginning of the year)
  init_int surveyfirstyear  // number of first year
  init_int surveylastyear    // number of last year (can be one more than years where catchdata are available)
  init_int surveyfirstage  // Number of first age group in survey.  
  init_int surveylastage
  !! ofs << "surveyfirstyear "  << surveyfirstyear << "surveylastyear " << surveylastyear;
  !! ofs << "surveyfirstage " << surveyfirstage << "surveylastage " << surveylastage << endl;
  int surveyfirstyearnr;
  int surveylastyearnr;
  int surveyfirstagenr
  int surveylastagenr;
  !!surveyfirstyearnr = surveyfirstyear-firstyear+1;
  !!surveylastyearnr = surveylastyear-firstyear+1;
  !!surveyfirstagenr = surveyfirstage-firstage+1;
  !!surveylastagenr = surveylastage-firstage+1;

  init_matrix ObsSurveyNr(surveyfirstyearnr,surveylastyearnr,surveyfirstagenr,surveylastagenr)  // surveyindices
  !! ofs << "ObsSurveyNr " << ObsSurveyNr << endl;

  init_number SurveyPropOfF; // Proportion of F before survey
  init_number SurveyPropOfM; // Proportion of M before survey
  !! ofs << "SurveyPropOfF " <<  SurveyPropOfF << "SurveyPropOfM " << SurveyPropOfM << endl ;  
  init_int FirstageWithConstantCatchability; // First age with linear relationship
  init_int FirstageWithFullcatchability;  // Flat selection above this
  init_int SurveyNRelationship;   //Relationship for younger fish.   Powercurve 1; Intercept 2
  !! ofs << "FirstageWithConstantCatchability " << FirstageWithConstantCatchability; 
  !! ofs << " FirstageWithFullcatchability " << FirstageWithFullcatchability;
  !! ofs << " SurveyNRelationship " << SurveyNRelationship << endl ;

  init_vector SigmaSurvey(surveyfirstagenr,surveylastagenr); // read in this version
  !! ofs << "SigmaSurvey " << endl << SigmaSurvey << endl;
  init_vector Surveyepsilon(surveyfirstagenr,surveylastagenr);
  !! ofs << "Surveyepsilon " << endl << Surveyepsilon << endl;

// Survey data.  (Assumed to be at the beginning of the year)
  init_int survey2firstyear  // number of first year
  init_int survey2lastyear    // number of last year (can be one more than years where catchdata are available)
  init_int survey2firstage  // Number of first age group in survey2.  
  init_int survey2lastage
  !! ofs << "survey2firstyear "  << survey2firstyear << "survey2lastyear " << survey2lastyear;
  !! ofs << "survey2firstage " << survey2firstage << "survey2lastage " << survey2lastage << endl;
  int survey2firstyearnr;
  int survey2lastyearnr;
  int survey2firstagenr
  int survey2lastagenr;
  !!survey2firstyearnr = survey2firstyear-firstyear+1;
  !!survey2lastyearnr = survey2lastyear-firstyear+1;
  !!survey2firstagenr = survey2firstage-firstage+1;
  !!survey2lastagenr = survey2lastage-firstage+1;

  init_matrix ObsSurvey2Nr(survey2firstyearnr,survey2lastyearnr,survey2firstagenr,survey2lastagenr)  // survey2indices
  !! ofs << "ObsSurvey2Nr " << ObsSurvey2Nr << endl;

  init_number Survey2PropOfF; // Proportion of F before survey2
  init_number Survey2PropOfM; // Proportion of M before survey2
  !! ofs << "Survey2PropOfF " <<  Survey2PropOfF << "Survey2PropOfM " << Survey2PropOfM << endl ;  
  init_int FirstageWithConstantCatchability2; // First age with linear relationship
  init_int FirstageWithFullcatchability2;  // Flat selection above this
  init_int Survey2NRelationship;   //Relationship for younger fish.   Powercurve 1; Intercept 2
  !! ofs << "FirstageWithConstantCatchability2 " << FirstageWithConstantCatchability2; 
  !! ofs << " FirstageWithFullcatchability2 " << FirstageWithFullcatchability2;
  !! ofs << " Survey2NRelationship " << Survey2NRelationship << endl ;
 init_vector SigmaSurvey2(survey2firstagenr,survey2lastagenr); // read in this version
  !! ofs << "SigmaSurvey2 " << endl << SigmaSurvey2 << endl;
  init_vector Survey2epsilon(survey2firstagenr,survey2lastagenr);
  !! ofs << "Survey2epsilon " << endl << Survey2epsilon << endl;

// fært til

  init_vector SigmaCInp(a1,nages); // Total SigmaC
  !! ofs << "SigmaCInp " << SigmaCInp << endl;

  init_vector SigmaCRatios(a1,nages); // Ratios of Sigmaa50, lnSigmaa50, Sigmaeffort to Csigma

  init_vector ProcessErrorWeight(nyrs-4,nyrs-1) // If any years are weighted out
  init_number sigmatotalcatch;  // cv when total catch is fitted to data.  
  !! ofs << "sigmatotalcatch " << sigmatotalcatch << endl ;
// log(a+x) 


  init_vector Catchepsilon(a1,nages);
  !! ofs << "Catchepsilon " << endl << Catchepsilon << endl;

// Numbers relating to SSB-Recruitment.    
  init_int SSBRectype	// if 1 Beverton and Holt, 2  Ricker. 3 Shannon
  init_number SpawnCv; // CV in spawning stock recruitment relationship ? estimate
  init_number Spawncorr;  // Autocorrelation in stock recruitment relationship
  init_number Spawnpow; // How Cv in recruitment depends on spawning stock.
  init_vector PropofFbeforeSpawning(a1,nages); //= 0.7; // Read later from file
  init_vector PropofMbeforeSpawning(a1,nages); //= 0.25; // Read later from file age
  init_int minssbage;
  
  !!ofs	<< "SSBRectype " << SSBRectype << " SpawnCv " << SpawnCv ;
  !!ofs << " Spawncorr " << Spawncorr << " Spawnpow " << Spawnpow << endl ;
  !!ofs << " PropofFbeforeSpawning " <<  PropofFbeforeSpawning << endl;
  !!ofs << " PropofMbeforeSpawning " <<  PropofMbeforeSpawning <<  endl;
  !!ofs << "minssbage " <<  minssbage ;

// Migrations.  


  init_int MigrationNumbers;  
  !! ofs << "MigrationNumbers " << MigrationNumbers << endl ; 
  init_vector MigrationYears(1,MigrationNumbers);
  !! ofs << "MigrationYears " << MigrationYears << endl ; 
  init_vector MigrationAges(1,MigrationNumbers);
  !! ofs << "MigrationAges " << MigrationAges << endl ; 

  init_vector Likeliweights(1,10); // Weights on likelhood comp, usually 1
  !! ofs << "Likeliweights " << Likeliweights << endl ;
// Harvesting rules  

  init_number CatchRule; // Number of catch rule.  
  init_number CvAssessment;	// Cv in assessment (at medium stocksize)
  init_number Assessmentcorr;  // Autocorrelation in assessment
  init_number Assessmentpow; // How CV in assessment depends on stocksize
  init_number MaxCatchChange; // Limit on changes in TAC
  init_number AssessmentBias;   
  init_number HarvestProportion; //Proportion taken in harvest rule
  init_number QuotaLeft // Quota left in last year (Fishing year special)
  init_number LastYearsTac // Quota left in last year (Fishing year special)
  init_number NextYearsTac // No error on next year in some cases. if 0 then use harvest control rule.   

  !!ofs << "Catchrule " << CatchRule << " CvAssessment " << CvAssessment << " Assessmentcorr " ;
  !!ofs	<< Assessmentcorr << " Assessmentpow " << Assessmentpow ;
  !!ofs  << " MaxCatchChange " << MaxCatchChange << endl ;
  !!ofs << "AssessmentBias" << AssessmentBias << endl;   
  !!ofs << "HarvestProportion " << HarvestProportion << endl;
  !!ofs << "QuotaLeft " << QuotaLeft << endl;
  !!ofs << "LastYearsTac " << LastYearsTac << endl;
  !!ofs << "NextYearsTac "  << NextYearsTac << endl;




  init_vector FutureCatch(nyrs+1,nyrs+nsimuyrs); // Catch for the next years needed for some catchrules;
  !! ofs << "FutureCatch" << FutureCatch << endl;
// Retro does not function if skipyears is > 0 ???
  int retroyears
  !! retroyears = lastdatayear - lastyear; // RETRO true.  
  !! ofs << "retroyears " << retroyears << endl;


PARAMETER_SECTION

// Natural mortality parameters

//  sdreport_vector sdM(1,nyrs+nsimuyrs); 
//  init_bounded_number dnM(0.1,2,3);
//  init_bounded_number Mdrift(-1,1,3);
    number dnM;
    number Mdrift
    vector sdM(1,nyrs+nsimuyrs);  

   init_bounded_number Processcorr(0.2,0.8,4);
//  init_bounded_number logSigmaM(-4,-1,5); 

// Weights  (Copy of data) 
  matrix CatchWts(1,nyrs+nsimuyrs,a1,nages)
  matrix ssbWts(1,nyrs+nsimuyrs,a1,nages)
  matrix SSBbyage(1,nyrs+nsimuyrs,a1,nages)
  matrix StockSexMat(1,nyrs+nsimuyrs,a1,nages)
  matrix CatchSexMat(1,nyrs+nsimuyrs,a1,nages)
  matrix StockWts(1,nyrs+nsimuyrs,1,nages)
  matrix ObsCatchInNumbers(1,nyrs,a1,nages);

// Migrations Read  from file
  init_bounded_vector logMigrationAbundance(1,MigrationNumbers,1,13,4);
	
// *****************------------------********************************
// parameters in stock-recr relationship.  The parameter SSBmax 
// is in reality 5*SSB50 in Beverton and Holt.  

  init_bounded_number logRmax(11.2,14.1,3); // 200 - 700 million 1 year old 
  init_bounded_number logSSBmax(3.5,7.5,3);  //   ca. 100 - 1800 thousand tonnes. 
  init_bounded_number SpawnCvest(0.001,0.8,3); 
  init_bounded_number Spawnpowest(0,.9,3);  //thg in recruitment variance
  init_bounded_number Spawncorrest(0,0.8,3);  //thg in recruitment variance
//  init_bounded_number dSha(0,2,3);  //thg distributing 1 ageclass to k gives maximum k**0.9 gain
  number dSha;  // has to be estimated in alternative 3.  
//  init_bounded_number fecunditymultiplier(1,8,5); // Proportion of eggs as function of weights. 
  number fecunditymultiplier; 

  vector N_1(1,nyrs+nsimuyrs-firstage); // Number of age 1
  vector predN_1(1,nyrs+nsimuyrs-firstage)  // Predicted number age 1.  
  vector resid_1(1,nyrs+nsimuyrs-firstage) // residuals 

//******************--------------*********************************
// Parameters relating to Selection function and fishing mortality

  
  
  init_bounded_vector lnEffort(1,nyrs+nsimuyrs,-2,2,1);  // log of Fishing mortality of oldest fish
  init_bounded_vector logSelection(a1,nages-2,-7,0,1);
  init_bounded_matrix log_F_dev(2,nyrs,a1,nages-2,-3,2,3) ; // deviation

// Parameters in 2nd degree polynomial to estimate measurement error

  init_bounded_number logSigmaCpar(-1,1,4);
  init_bounded_number logSigmaSurveypar(-1,1,4);
  init_bounded_number logSigmaSurvey2par(-1,1,4);

// ***********************************************************

// **********************************************
  matrix log_F(1,nyrs+nsimuyrs,1,nages)
  matrix F(1,nyrs+nsimuyrs,1,nages)
  matrix natM(1,nyrs+nsimuyrs,1,nages);   // Natural mortality 
  matrix Z(1,nyrs+nsimuyrs,1,nages);  // Total mortality
  matrix Spc(1,nyrs+nsimuyrs,1,nages);  // Survival percent
  matrix PropInCatch(1,nyrs+nsimuyrs,a1,nages); // Modelled proportion in catch
  vector TotalCalcCatchInNumbers(1,nyrs+nsimuyrs); // modeled catch in numbers by year
  number firsttime; // for printing
  matrix CalcCatchInNumbers(1,nyrs+nsimuyrs,a1,nages); // modelled catch in no by year and age
  matrix RCdiff(1,nyrs,a1,nages);
  vector SigmaC(a1,nages); // Standard deviation in Cno. 
  vector SigmaCtot(a1,nages); // Standard deviation in Cno. 
  
  vector meansel(a1,nages); // mean selection
  vector progsel(a1,nages); // selection in prognosis (last ?? years)



// Initial population 
  init_bounded_vector log_initialpop(2,nages,0.3,14);  // log of initial population
  init_bounded_vector log_recr(1,nyrs+nsimuyrs,1,14) ;// log of recruitment from age 1.  
  matrix N(1,nyrs+nsimuyrs,1,nages);  // Number in stock

  

  
// Survey data Maybe put CalcSurveyNr and CalcSurveybio as sdreport
 
  init_bounded_vector SurveylnQest(surveyfirstagenr,FirstageWithFullcatchability-firstage+1,-40,0,5);  // catchability in survey. 
  init_bounded_number lnIncreaseInAgeoneCatchabilityeAfter2002(-1.5,1.5,3) 

//  init_bounded_dev_vector SurveylnYeareffect(surveyfirstyearnr,surveylastyearnr,-2,2,4);
  vector SurveylnYeareffect(surveyfirstyearnr,surveylastyearnr);

//  init_bounded_number logSigmaYearEffect(-4,-1,5);
  init_bounded_vector SurveyPowerest(surveyfirstagenr,FirstageWithConstantCatchability-firstage,1,3,5);   // Power curve for first age groups.  
  vector SurveylnQ(surveyfirstagenr,surveylastagenr);   
  vector SurveyPower(surveyfirstagenr,surveylastagenr);
  vector surveyintercept(surveyfirstagenr,surveylastagenr);
  matrix CalcSurveyNr(1,nyrs+nsimuyrs,surveyfirstagenr,surveylastagenr);  // estimated surveyindices
  matrix RSsurveydiff(surveyfirstyearnr,surveylastyearnr,surveyfirstagenr,surveylastagenr);  // Residuals from survey fit
  vector CalcSurveybio(1,nyrs+nsimuyrs); 
  vector ObsSurveybio(surveyfirstyearnr,surveylastyearnr); 
  number pZ;  // Z before survey.  

 
 // Survey2
 

  init_bounded_vector Survey2lnQest(survey2firstagenr,FirstageWithFullcatchability2-firstage+1,-40,0,3);  // catchability in survey2.  
//  init_bounded_dev_vector Survey2lnYeareffect(survey2firstyearnr,survey2lastyearnr,-2,2,4);
  vector Survey2lnYeareffect(survey2firstyearnr,survey2lastyearnr);

  init_bounded_vector Survey2Powerest(survey2firstagenr,FirstageWithConstantCatchability2-firstage,1,3,5);   // Power curve for first age groups.  
  vector Survey2lnQ(survey2firstagenr,survey2lastagenr);   
  vector Survey2Power(survey2firstagenr,survey2lastagenr);
  vector survey2intercept(survey2firstagenr,survey2lastagenr);
  matrix CalcSurvey2Nr(1,nyrs+nsimuyrs,survey2firstagenr,survey2lastagenr);  // estimated survey2indices
  matrix RSsurvey2diff(survey2firstyearnr,survey2lastyearnr,survey2firstagenr,survey2lastagenr);  // Residuals from survey2 fit
  vector CalcSurvey2bio(1,nyrs+nsimuyrs);
  vector ObsSurvey2bio(survey2firstyearnr,survey2lastyearnr); 
  

  
  

// Biomass data that are stored as sdreport 
  
  matrix predicted_N(nyrs+1,nyrs+nsimuyrs,1,nages)
  sdreport_vector Spawningstock(1,nyrs+nsimuyrs);
// Spawning stock based on survey weights and maturity.  
  vector OldSpawningstock(1,nyrs+nsimuyrs)
  sdreport_vector CbioR(1,nyrs+nsimuyrs)  // Real cbio
  sdreport_vector Cbio1(1,nyrs+nsimuyrs)  // catch wts
  sdreport_vector Cbio2(1,nyrs+nsimuyrs)  // stock weights
  sdreport_vector RelCbioR(nyrs-3,nyrs+nsimuyrs) 
  sdreport_vector RelCbio1(nyrs-3,nyrs+nsimuyrs)  
  sdreport_vector RelCbio2(nyrs-3,nyrs+nsimuyrs)  
  sdreport_vector RelSpawningstock(nyrs-3,nyrs+nsimuyrs)  

  sdreport_vector RefF(1,nyrs+nsimuyrs);
  sdreport_vector CalcCatchIn1000tons(1,nyrs+nsimuyrs);
  sdreport_vector HarvestRatio(1,nyrs+nsimuyrs);
  sdreport_vector FishingYearCatch(nyrs+1,nyrs+nsimuyrs);
//  vector FishingYearCatch(nyrs+1,nyrs+nsimuyrs);
  vector CatchIn1000tons(1,nyrs); // From data.  
  vector CatchIn1000tonsforRetro(1,nyrs+retroyears); // From data.  
  vector Shannon(1,nyrs+nsimuyrs-firstage); // Shannon index
  sdreport_vector N3(1,nyrs+nsimuyrs);
  sdreport_vector N1(1,nyrs+nsimuyrs);
  sdreport_vector CurrentN(1,nages);
  sdreport_vector NextYearsN(1,nages);

// Catchrule and related things.   
  init_bounded_vector Assessmenterr(1,nsimuyrs,-5,5);
//  vector Assessmenterr(1,nsimuyrs);
   init_bounded_vector Weighterr(1,nsimuyrs,-5,5); 
//   vector Weighterr(1,nsimuyrs);

  vector LnLikelicomp(1,10);  // likelihood function
  objective_function_value LnLikely

  number printcounter;
  matrix Scorrmat(1,surveylastagenr-surveyfirstagenr+1,1,surveylastagenr-surveyfirstagenr+1);
  number SurveylnDet;  
  matrix Scorrmat2(1,survey2lastagenr-survey2firstagenr+1,1,survey2lastagenr-survey2firstagenr+1);
  number Survey2lnDet;  

  init_bounded_vector RecrDrift(1,1,-0.04,0.04,4);
// Parameters that are sometimes estimated

  number Surveycorr;
  number Survey2corr;

// Special for catage 
 //init_bounded_number logSigmaCpar_2(-4,-2,4);
  number logSigmaCpar_2;  // sometime estimated
  number SigmaCpar_a;  // sometime estimated


TOP_OF_MAIN_SECTION
  gradient_structure::set_MAX_NVAR_OFFSET(1500);
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(1500);
  arrmblsize = 50000000;

RUNTIME_SECTION 
  convergence_criteria .1, .01, .0001, .0000001
  maximum_function_evaluations 800000



PRELIMINARY_CALCS_SECTION
  SurveylnYeareffect = 0;
  Survey2lnYeareffect = 0;

  RecrDrift = 0.0;
// Parameters that are sometimes estimated. 
  SSBbyage = 0;
  Surveycorr = 0.38; // from adapt
  Survey2corr = 0.38; // from adapt

  Processcorr=0.5;

  logSigmaCpar_2 = log(0.03);
  SigmaCpar_a = 7.3;  // mat alltaf í lágmarki

  ofstream outfile;
  outfile.open("result");
  outfile << "year ssb effort N1 N3 Cbio Cbio4plus CalcCatch RefF" << endl;
  outfile.close();
// Nat M parameters
  dnM = 0.2;;
  Mdrift = 0;
//  logSigmaM = log(0.1);



// initial values of SSB-recr param
  fecunditymultiplier = 4.3;
  Spawnpowest = Spawnpow;
  Spawncorrest = Spawncorr;
  logRmax = 12.6;  // u.þ.b 300 million 1 years 
  logSSBmax = 6.2; // u.þ.b 500 þ.  
  SpawnCvest = SpawnCv;
  Assessmenterr = 0;  // initial value of estimated variable.  
  Weighterr = 0; 

  log_initialpop = 11;  // 60 million
  log_recr = 12.3;  //200 million

 
// Survey parameters
  SurveyPowerest = 1;
 Survey2Powerest = 1;


// copying weights to matrices available for all years.  
// This setup is to increase flexibility in simulations. 
 int i = 0;
 int j = 0;
 int skipyears = firstyear-firstdatayear;

 for(i = 1 ; i <= nyrs; i++)
   ObsCatchInNumbers(i) = ObsCatchInNumbersData(i+skipyears);
 for(i = 1 ; i <= min(ndatayrs+1-skipyears,min(ndatayrs+1-skipyears,nyrs+nsimuyrs)); i++) {
   CatchWts(i) = CatchWtsData(i+skipyears);
   ssbWts(i) = ssbWtsData(i+skipyears);
   StockSexMat(i) = StockSexMatData(i+skipyears);
   CatchSexMat(i) = CatchSexMatData(i+skipyears);
   StockWts(i) = StockWtsData(i+skipyears);
 }
 if(nyrs+nsimuyrs > ndatayrs+1-skipyears) {
    for(i = ndatayrs+2-skipyears ; i <= nyrs+nsimuyrs; i++) {
      ssbWts(i) = ssbWtsData(ndatayrs+2);
      StockSexMat(i) = StockSexMatData(ndatayrs+2);
      CatchSexMat(i) = CatchSexMatData(ndatayrs+2);
      CatchWts(i) = CatchWtsData(ndatayrs+2);
      StockWts(i) = StockWtsData(ndatayrs+2);
    }
 }
// Initial guess of migrations 30 million individuals.  
   
   logMigrationAbundance = log(30000);

// Calculate the catch in 1000 tonnes. 
   for(i = 1; i <= nyrs; i++) 
     CatchIn1000tons(i) = sum(elem_prod(CatchWts(i),ObsCatchInNumbers(i)))/1.0e6;
// Used for simulation in retros.  
   for(i = 1; i <= min(nyrs+retroyears,ndatayrs-skipyears); i++)
     if(i <= nyrs+nsimuyrs)  // min does not work on 3.  
       CatchIn1000tonsforRetro(i) = sum(elem_prod(CatchWts(i),ObsCatchInNumbersData(i+skipyears)))/1e6;


// Calculate correlation matrix for survey not estimated here
  int k;
  for(j = 1; j <= surveylastagenr-surveyfirstagenr+1; j++) {  
    Scorrmat(j,j) = 1.0*square(SigmaSurvey(j+surveyfirstagenr-1));
    for(k = 1; k < j; k++) {
      Scorrmat(j,k) = pow(Surveycorr,agedist(j,k,2,0.7))*SigmaSurvey(j+surveyfirstagenr-1)*SigmaSurvey(k+surveyfirstagenr-1);
      Scorrmat(k,j) = Scorrmat(j,k);
    }
  }
  cout << Scorrmat << endl;
  SurveylnDet = log(det(Scorrmat));
  Scorrmat = inv(Scorrmat);
// Finished calculating correlation matrix for survey.  
  for(j = 1; j <= survey2lastagenr-survey2firstagenr+1; j++) {  
    Scorrmat2(j,j) = 1.0*square(SigmaSurvey2(j+survey2firstagenr-1));
    for(k = 1; k < j; k++) {
      Scorrmat2(j,k) = pow(Survey2corr,agedist(j,k,2,0.7))*SigmaSurvey2(j+survey2firstagenr-1)*SigmaSurvey2(k+survey2firstagenr-1);
      Scorrmat2(k,j) = Scorrmat2(j,k);
    }
  }
  cout << Scorrmat2 << endl;
  Survey2lnDet = log(det(Scorrmat2));
  Scorrmat2 = inv(Scorrmat2);

  SigmaC = 0.5;
  SigmaCtot = 0.5;
  firsttime = 0;
  printcounter = 1;

// Biomass from survey
  ObsSurveybio= -1;  // -1 is to identify NA in output files.  
  CalcSurveybio = -1; 
  for(i =  surveyfirstyearnr ; i<= surveylastyearnr ; i++)
     ObsSurveybio(i) = sum(elem_prod(ObsSurveyNr(i),StockWts(min(i,nyrs+nsimuyrs))(surveyfirstagenr,surveylastagenr)))/1000;
   ObsSurveybio= -1;  // -1 is to identify NA in output files.  
  CalcSurvey2bio = -1; 
  for(i =  survey2firstyearnr ; i<= survey2lastyearnr ; i++)
     ObsSurvey2bio(i) = sum(elem_prod(ObsSurvey2Nr(i),StockWts(min(i,nyrs+nsimuyrs))(survey2firstagenr,survey2lastagenr)))/1000;
       
PROCEDURE_SECTION
  update_weights();
//  cout << "getm"<<flush;
  get_mortality_and_survivial_rates();
//  cout << "getn"<<flush;
  get_numbers_at_age();
//  cout << "getc";
  get_catch_at_age();
//  cout << "eval" <<flush;
  evaluate_the_objective_function();

// Update future weights error only Half weight on next year.  
FUNCTION update_weights
  int i; 
  int j;
  int skipyears = firstyear-firstdatayear;
  if(nyrs+nsimuyrs > ndatayrs-skipyears) {
    i = ndatayrs+1-skipyears ;
    for(j = a1; j <= nages; j++){
      ssbWts(i,j) = mfexp(log(ssbWtsData(ndatayrs+1,j))+Weighterr(i-nyrs)/2);
      CatchWts(i,j) = mfexp(log(CatchWtsData(ndatayrs+1,j))+Weighterr(i-nyrs)/2);
    }
    for(j = 1 ; j <= nages; j++)
      StockWts(i,j) = StockWtsData(ndatayrs+1,j);
  }
  if(nyrs+nsimuyrs > ndatayrs+1-skipyears) {
    for(i = ndatayrs+2-skipyears ; i <= nyrs+nsimuyrs; i++) {
      for(j = a1; j <= nages; j++){
        ssbWts(i,j) = mfexp(log(ssbWtsData(ndatayrs+2,j))+Weighterr(i-nyrs));
        CatchWts(i,j) = mfexp(log(CatchWtsData(ndatayrs+2,j))+Weighterr(i-nyrs));
      }
      for(j = 1 ; j <= nages; j++)
        StockWts(i,j) = mfexp(log(StockWtsData(ndatayrs+2,j))+Weighterr(i-nyrs));
    }
  }
// *******************-----------------***************

// Function to calculate fishing, natural and total mortality.  
// Mean selection pattern and selection pattern for the last
// 3 years are calculated.  

FUNCTION get_mortality_and_survivial_rates
  int refage1 = 5;  //F 5 to 
  int refage2 = 10; // 10 for cod.  
  int i = 0;
  int j = 0;
  int age = 0;
  calcNaturalMortality3(); // estimate natural mortality


  calcFishingMortality3();

  for(i = 1 ;i <= nyrs ; i++){
    for(j = a1; j <=nages; j++)
      Z(i,j) = F(i,j) + natM(i,j) ; // Total mortality.  M only depends on age.
    for(j = 1; j < a1; j++) 
      Z(i,j) = natM(i,j) ; // No fishery on youngest.  
  }
  for(j = a1; j <= nages; j++) {
    meansel(j) = 0;
    progsel(j) = 0;
    for(i = 1; i <= nyrs; i++)  
      meansel(j)  += F(i,j)/mfexp(lnEffort(i));
    for(i = nyrs-4; i <= nyrs; i++)  
      progsel(j)  += F(i,j)/mfexp(lnEffort(i));
  } 
  meansel /= nyrs;
  progsel /= 5.0; 

// Use prog selection of all the time period for prognosis.  
  for(i = nyrs+1 ;i <= nyrs+nsimuyrs ; i++)
  {
    for(j = a1; j <=nages; j++){
       F(i,j) = mfexp(lnEffort(i))*progsel(j);
       Z(i,j) = F(i,j) + natM(i,j) ; // Total mortality.  M only depends on age.  
    }
    for(j = 1; j < a1; j++) 
	Z(i,j) = natM(i,j);  // No fishing mortality of youngest.  
  }
  
// Calculate reference fishing mortality for example F5-10
// Then refage1 = 5 and refage2 = 10;

  for(i = 1; i <= nyrs+nsimuyrs; i++) {
    RefF(i) = 0;
    for(j = refage1-firstage+1 ; j <= refage2-firstage+1 ; j++) 
      RefF(i) += F(i,j);
  }
  RefF /= refage2-refage1+1;
  // get the survival rate
  Spc=mfexp(-1.0*Z);

// Natural mortality fixed  

FUNCTION calcNaturalMortality3
   int i;
   int j;
   dvariable age;
   for(i = 1; i <= nyrs+nsimuyrs; i++){
      for(j = 1; j <= nages; j++)
	natM(i,j) = dnM+0.01*i*Mdrift;
   }
   for(i = 1; i <= nyrs+nsimuyrs; i++)
     sdM(i) = natM(i,6);   


// Calculate numbers from initial numbers, recruitment and 
// total mortality.  
  
FUNCTION get_numbers_at_age
  N = 0;
  int i = 0;
  int j = 0;
  for(i = 1; i <= MigrationNumbers ; i++) 
    if(int(MigrationYears(i)) >= firstyear & int(MigrationYears(i)) <= lastyear+nsimuyrs)
      N(int(MigrationYears(i)-firstyear+1),int(MigrationAges(i)-firstage+1)) += mfexp(logMigrationAbundance(i));

  for(i = 1; i <= nyrs+nsimuyrs; i++) 
   N(i,1) = mfexp(log_recr(i));
  for(i = 2; i <= nages; i++) 
   N(1,i) = mfexp(log_initialpop(i));
  for (i=1;i<nyrs+nsimuyrs;i++){
    for (j=1;j<nages;j++)
      N(i+1,j+1) += N(i,j)*Spc(i,j);
    if(PlusGroup == 1)  N(i+1,nages) += N(i,nages)*Spc(i,nages);
  }
  // Could be replaced by submatrix operators
  for(i = nyrs+1; i <=nyrs+nsimuyrs;i++)
    predicted_N(i) = N(i);  // predicted_N is sdreport matrix
  CurrentN = N(nyrs);
  NextYearsN = N(nyrs+1);
  for(i = 1; i <= nyrs+nsimuyrs; i++){
    N3(i) = N(i,3);
    N1(i) = N(i,1);
  }

// Various versions of catchable biomass.  Cbio is based on selectionpattern
// Cbio2 on all fishes older than 3 and catch weights and Cbio1 on all fishes 
// older than 3 and survey Weights.  
// put certain percent of Z before spawning when calculating Spawning stock
// Propof F and M before spawning should possibly be age - related.   

  int year = 0; 

  for(i = 1;i<=nyrs+nsimuyrs;i++) {
    OldSpawningstock(i) = 0;
    for(j = minssbage; j <= nages; j++)
 	OldSpawningstock(i) += N(i,j)*ssbWts(i,j)*CatchSexMat(i,j)*
	mfexp(-(natM(i,j)*PropofMbeforeSpawning(j)+F(i,j)*PropofFbeforeSpawning(j)));
  }
  for(i = 1;i<=nyrs+nsimuyrs;i++) {
    Spawningstock(i) = 0;
    for(j = minssbage; j <= nages; j++){
 	SSBbyage(i,j) = N(i,j)*ssbWts(i,j)*StockSexMat(i,j)*
	mfexp(-(natM(i,j)*PropofMbeforeSpawning(j)+F(i,j)*PropofFbeforeSpawning(j)));
 	Spawningstock(i) += SSBbyage(i,j); 
    }
    Cbio1(i) = sum(elem_prod(N(i)(4,nages),StockWts(i)(4,nages)))/1.0e6;
    Cbio2(i) = sum(elem_prod(N(i)(4,nages),CatchWts(i)(4,nages)))/1.0e6;
    CbioR(i) = 0; 
    for(j = a1; j <= nages; j++) 
       CbioR(i)  = CbioR(i) + N(i,j)*CatchWts(i,j)*MeanSel(j)*(1-exp(-Z(i,j)))/Z(i,j);
   }
   CbioR/= 1.0e6;
   Spawningstock /= 1.0e6;
   OldSpawningstock /= 1.0e6;
   SSBbyage /= 1.0e6;

//  Ratios of spawning stock and spawning stock in the beginning of 2001.  

   RelSpawningstock = Spawningstock(nyrs-3,nyrs+nsimuyrs)/Spawningstock(nyrs+2);
   RelCbioR = CbioR(nyrs-3,nyrs+nsimuyrs)/CbioR(nyrs+2);
   RelCbio1 = Cbio1(nyrs-3,nyrs+nsimuyrs)/Cbio1(nyrs+2);
   RelCbio2 = Cbio2(nyrs-3,nyrs+nsimuyrs)/Cbio2(nyrs+2);



// Program to calculate catch in numbers, catch in tonnes and proportion of
// each age group in catch.    

FUNCTION get_catch_at_age
  int i = 0;
// C = F/Z*(1-exp(-Z))*N
  for(i = 1;i<=nyrs+nsimuyrs;i++)
    CalcCatchInNumbers(i )=elem_prod(elem_div(F(i)(a1,nages),Z(i)(a1,nages)),elem_prod(1.-Spc(i)(a1,nages),N(i)(a1,nages)));

// Calculate Catchh in 1000 tonnes and total catch in numbers.  
// N is in thousands, weight in g so division by 1e6 is used to convert 
// to 1000 tonnes.  

  TotalCalcCatchInNumbers = rowsum(CalcCatchInNumbers);
  CalcCatchIn1000tons = rowsum(elem_prod(CalcCatchInNumbers,CatchWts))/1.0e6;
  for(i = 1 ; i <= nyrs+nsimuyrs; i++){
    HarvestRatio(i) = CalcCatchIn1000tons(i)/CbioR(i); 
    PropInCatch(i) = CalcCatchInNumbers(i)/TotalCalcCatchInNumbers(i);
  }
	
// Distance between agegroups (must be higher than minage -1)
// age1 must be higher han age 2.  
FUNCTION dvariable agedist(int age1, int age2, int minage,dvariable power)
	dvariable result;
        dvariable bignumber = 100;
	if((age1 <= minage) | (age2 <= minage)) return bignumber; // practically independent
        return((pow(dvariable(age1-minage),dvariable(power))
	-pow(dvariable(age2-minage),dvariable(power)))/
	(pow(dvariable(2),dvariable(power))-pow(dvariable(1),dvariable(power))));



FUNCTION evaluate_the_objective_function

 dvar_vector SigmaCprocess(1,nages-a1);
 double eps = 1e-6;
 int i = 0;
 int j = 0;
 int k = 0;
 printcounter = printcounter + 1;
 LnLikelicomp = 0;
 LnLikelicomp(3) = Catch_loglikeliNocorr();
// dvariable Processcorr = 0.7;
 dvar_matrix Pcorrmat(1,nages-a1,1,nages-a1);

 dvariable PlnDet;
 dvar_vector Pdiff(1,nages-a1);
// Must start with L3 here as SigmaC is used.  
//     cout << "L3"<<flush;
 for(j = a1; j <= nages-1; j++)
    SigmaCprocess(j-a1+1) = sqrt(square(SigmaCtot(j))*SigmaCRatios(j));  // Process error.  
 for(j = 1; j <= nages - a1; j++) {  
   Pcorrmat(j,j) = 1.0*square(SigmaCprocess(j));
   for(k = 1; k < j; k++) {
     Pcorrmat(j,k) = pow(Processcorr,agedist(j+2,k+2,2,0.3))*SigmaCprocess(j)*SigmaCprocess(k);
     Pcorrmat(k,j) = Pcorrmat(j,k);
   }
  }
 PlnDet = log(det(Pcorrmat));
 Pcorrmat = inv(Pcorrmat);

 LnLikelicomp(1) = 0;
 for(i = 1; i<= nyrs-5; i++) {
   for(j = 1; j <= nages-a1; j++)
      Pdiff(j) = log(F(i+1,j+a1-1))-log(F(i,j+a1-1));
    LnLikelicomp(1) += 0.5*(PlnDet)+0.5*Pdiff*Pcorrmat*Pdiff;
  }

   for(i = nyrs-4; i<= nyrs-1; i++) {
     for(j = 1; j <= nages-a1; j++)
        Pdiff(j) = log(F(i+1,j+a1-1))-log(F(i,j+a1-1));
      LnLikelicomp(1) += (0.5*(PlnDet)+0.5*Pdiff*Pcorrmat*Pdiff) *ProcessErrorWeight(i);
  }
        
  
// Variations in Total catch  sigmatotalcatch is typically low to 
// follow catch well.  
//     cout << "L4" ;    
  LnLikelicomp(4) = sum(square(log(CatchIn1000tons)-log(CalcCatchIn1000tons(1,nyrs))))/
  (2.*square(sigmatotalcatch))+ nyrs*log(sigmatotalcatch);

//     cout << "L5"<<flush;
//SSBrecrweight = 0 means that SSB-recr function is not used 
//default values for SSBrecrweight is 1,
  LnLikelicomp(5) = SSB_Recruitment_loglikeli_nocorr(); 

//Survey weight can be very low or 0. AD model builder has no problem 
//With independed variables not used.  
  
//     cout << "L6"<<flush;
  LnLikelicomp(6) = Survey_loglikeli1();
  LnLikelicomp(2) = Survey_loglikeli2();
//  LnLikelicomp(6) = 0;
// LnLikelicomp(9) er sett.  
  WeightCorr(); 
  dvariable SigmaYearEffect = 0.1; //mfexp(logSigmaYearEffect);
//   LnLikelicomp(9) = sum(square(SurveylnYeareffect))/(2*square(SigmaYearEffect)) + (surveylastyear-surveyfirstyear+1)*log(SigmaYearEffect);
;

  dvariable SigmaM = 0.2; // mfexp(logSigmaM);0.1; // Hátt randomw walk á Mmfexp(logSigmaM);
//  LnLikelicomp(10) = sum(square(log(--dnM(2,nyrs+nsimuyrs))-log(dnM(1,nyrs+nsimuyrs-1))))
//        /(2*square(SigmaM))+(nyrs-1)*log(SigmaM);

;  

// Catchrule.  Might have to make it differentiable complications due to fishing year.  
  IceCodHarvestrule();
//    SpecifiedCatch(); 
   dvariable LnLikelytmp;
//   cout << "LnLikelicomp " << LnLikelicomp << endl ;
   LnLikely = sum(elem_prod(LnLikelicomp,Likeliweights));
//   cout << LnLikelicomp << endl << endl;
//******************-----------------------************************

 
// Function to calculate fishing mortality. Change in selection between 
// 1976 and 1977.   
FUNCTION calcFishingMortality3 
  int i = 0;
  int j = 0;
  for(i = 1 ;i <= nyrs ; i++){
    for(j = a1; j <= nages-2; j++)
       log_F(i,j) = logSelection(j)+lnEffort(i);
    log_F(i,nages-1) = lnEffort(i);
    for(j = a1; j <= nages-2; j++)       
       if(active(log_F_dev) && i != 1) 
          log_F(i,j) += log_F_dev(i,j);
    log_F(i,nages) = log_F(i,nages-1);
  } 
  F = mfexp(log_F) ;
   
 

// Likelihood function for Catch in numbers.  Few problems as solve uses 
// matrices with row and column indices beginning on 1. Question if RCdiff
// should be indexed to begin on a1 or 1.   

FUNCTION dvariable Catch_loglikeliNocorr()
 dvariable value = 0;
 dvariable SigmaCpar_1 = -1.5;
 dvar_vector Cdiff(1,nages-a1+1);
 dvariable age;
 int i;
 int j; 
 int k;
 for(j = a1; j <= nages; j++) {
   age = firstage+j-1;
     SigmaCtot(j) = mfexp(logSigmaCpar)*SigmaCInp(j);
     SigmaC(j) = sqrt(square(SigmaCtot(j))*(1-SigmaCRatios(j)));  // Process error.  
//   SigmaC(j) = mfexp(SigmaCpar_1+mfexp(logSigmaCpar_2)*square(age - SigmaCpar_a))*mfexp(logSigmaCpar);
 }
 for(i = 1; i <=  nyrs; i++) {
   for( j = a1; j <= nages; j++) {
      RCdiff(i,j) = log( (ObsCatchInNumbers(i,j)+Catchepsilon(j))/(CalcCatchInNumbers(i,j)+Catchepsilon(j)) );
      value += 0.5*square(RCdiff(i,j)/SigmaC(j)) + log(SigmaC(j));
    }
 }
 return value;
FUNCTION dvariable Survey_loglikeli2()
// Survey indices Look if surveylastyear > nyrs Add time of year that survey takes place.
//   i <= min(nyrs+nsimuyrs,survey2lastyear) is useful in retros.  
// After first age with FirstageWithFullcatchability the selection is flat
  int i;
  int j;
  int k;
//  dvariable Survey2corr = 0.39;
  dvariable age;
  dvariable value = 0;
  dvariable eps = 1e-3;  // small number  dvariable value;
  dvariable pZ;  // Z before survey.  
  dvariable sign;
  dvar_vector SigmaSurvey2tmp(1,survey2lastagenr-survey2firstagenr+1);  
  dvar_vector Survey2diff(1,survey2lastagenr-survey2firstagenr+1);
//  dvar_matrix Scorrmat2(1,survey2lastagenr-survey2firstagenr+1,
//		1,survey2lastagenr-survey2firstagenr+1);

  Survey2Power = 1;  // Changed for youngest fish.  

// Set up variances as a parabola.  SigmaSurvey2tmp is indexed from age 1 and 
// used for other purposes later.  
  if(active(Survey2lnQest)) {
   for( j  = survey2firstagenr; j <= FirstageWithFullcatchability2; j++)
     Survey2lnQ(j) = Survey2lnQest(j);
   for( j  = FirstageWithFullcatchability2-firstage+1; j <= survey2lastagenr; j++)
     Survey2lnQ(j) = Survey2lnQest(FirstageWithFullcatchability2-firstage+1);
   for(j = survey2firstagenr; j<  FirstageWithConstantCatchability2-firstage+1; j++)
    Survey2Power(j) = Survey2Powerest(j);

  }
// guess in when Survey2lnQ is not active.  power is 1 in that case.  
// not use the survey2 further than nyrs+1 or even nyrs in some cases
// if survey2 is not available at the time of assessment.  
  else {
    for(j = survey2firstagenr; j <= survey2lastagenr; j++){
      Survey2lnQ(j) = 0; 
      for(i = survey2firstyearnr; i <= min(nyrs+1, survey2lastyearnr); i++) 
        if(ObsSurvey2Nr(i,j) != -1) 
          Survey2lnQ(j) += log((ObsSurvey2Nr(i,j)+Survey2epsilon(j))/N(i,j));
    }
    Survey2lnQ/= (min(nyrs+1,survey2lastyearnr)-survey2firstyearnr+1);
    Survey2lnQest = Survey2lnQ(survey2firstagenr,FirstageWithFullcatchability2);  
  }
  for( i = survey2firstyearnr; i <= min(nyrs+1, survey2lastyearnr); i++) {
    for(j = survey2firstagenr; j <= survey2lastagenr; j++) {
      pZ = Survey2PropOfF*F(i,j)+Survey2PropOfM*natM(i,j);
      CalcSurvey2Nr(i,j) = mfexp(log(N(i,j)*mfexp(-pZ))*Survey2Power(j)+Survey2lnQ(j)+Survey2lnYeareffect(i));
      Survey2diff(j-survey2firstagenr+1) = log( (ObsSurvey2Nr(i,j)+Survey2epsilon(j))/(CalcSurvey2Nr(i,j)+Survey2epsilon(j)) );
      RSsurvey2diff(i,j) = Survey2diff(j-survey2firstagenr+1); 
    }
    value  += 0.5*(Survey2lnDet)+0.5*(survey2lastagenr-survey2firstagenr+1)*logSigmaSurvey2par+0.5*Survey2diff*Scorrmat2*Survey2diff/mfexp(logSigmaSurvey2par);

  }
  for(i =  survey2firstyearnr ; i<= min(survey2lastyearnr,nyrs+nsimuyrs) ; i++)
    CalcSurvey2bio(i) = sum(elem_prod(CalcSurvey2Nr(i),StockWts(i)(survey2firstagenr,survey2lastagenr)))/1000;
  return value;

// *************************-------------------------*********************    
//************************************************************************
// Log-likelihood function for Survey data.  Based on age-disaggregated 
// Survey data and lognormal errors. Like with catch_loglikeli1 some 
// complications arise from the  correlations.   

FUNCTION dvariable Survey_loglikeli1()
// Survey indices Look if surveylastyear > nyrs Add time of year that survey takes place.
//   i <= min(nyrs+nsimuyrs,surveylastyear) is useful in retros.  
// CV in survey is from adapt multiplied by mfexp(sigmasurveypar)
// After first age with FirstageWithFullcatchability the selection is flat
  int i;
  int j;
  int k;
//  dvariable Surveycorr = 0.39;
  dvariable age;
  dvariable value = 0;
  dvariable eps = 1e-3;  // small number  dvariable value;
  dvariable sign;
  dvar_vector Surveydiff(1,surveylastagenr-surveyfirstagenr+1);

  SurveyPower = 1;  // Changed for youngest fish.  

  if(active(SurveylnQest)) {
   for( j  = surveyfirstagenr; j <= FirstageWithFullcatchability; j++)
     SurveylnQ(j) = SurveylnQest(j);
   for( j  = FirstageWithFullcatchability-firstage+1; j <= surveylastagenr; j++)
     SurveylnQ(j) = SurveylnQest(FirstageWithFullcatchability-firstage+1);
   for(j = surveyfirstagenr; j<  FirstageWithConstantCatchability-firstage+1; j++)
    SurveyPower(j) = SurveyPowerest(j);

  }
// guess in when SurveylnQ is not active.  power is 1 in that case.  
// not use the survey further than nyrs+1 or even nyrs in some cases
// if survey is not available at the time of assessment.  
  else {
    for(j = surveyfirstagenr; j <= surveylastagenr; j++){
      SurveylnQ(j) = 0; 
      for(i = surveyfirstyearnr; i <= min(nyrs+1, surveylastyearnr); i++) 
        if(ObsSurveyNr(i,j) != -1) 
          SurveylnQ(j) += log((ObsSurveyNr(i,j)+Surveyepsilon(j))/N(i,j));
    }
    SurveylnQ/= (min(nyrs+1,surveylastyearnr)-surveyfirstyearnr+1);
    SurveylnQest = SurveylnQ(surveyfirstagenr,FirstageWithFullcatchability);  
  }
  for( i = surveyfirstyearnr; i <= min(nyrs+1, surveylastyearnr); i++) {
    for(j = surveyfirstagenr; j <= surveylastagenr; j++) {
      pZ = SurveyPropOfF*F(i,j)+SurveyPropOfM*natM(i,j);
      CalcSurveyNr(i,j) = mfexp(log(N(i,j)*mfexp(-pZ))*SurveyPower(j)+SurveylnQ(j)+SurveylnYeareffect(i));
      if(j == 1 && (i + firstyear -1) > 2002){ 
         CalcSurveyNr(i,j) = mfexp(log(N(i,j)*mfexp(-pZ))*SurveyPower(j)+SurveylnQ(j)+lnIncreaseInAgeoneCatchabilityeAfter2002+SurveylnYeareffect(i));
      }
      Surveydiff(j-surveyfirstagenr+1) = log( (ObsSurveyNr(i,j)+Surveyepsilon(j))/(CalcSurveyNr(i,j)+Surveyepsilon(j)) );
      RSsurveydiff(i,j) = Surveydiff(j-surveyfirstagenr+1); 
    }
    value  += 0.5*(SurveylnDet)+0.5*(surveylastagenr-surveyfirstagenr+1)*logSigmaSurveypar+0.5*Surveydiff*Scorrmat*Surveydiff/mfexp(logSigmaSurveypar);
  }
  for(i =  surveyfirstyearnr ; i<= min(surveylastyearnr,nyrs+nsimuyrs) ; i++)
    CalcSurveybio(i) = sum(elem_prod(CalcSurveyNr(i),StockWts(i)(surveyfirstagenr,surveylastagenr)))/1000;
  return value;


// *************************-------------------------*********************    


// Likelihood function for Spawning Stock - Recruitment Relationship
// Convenient to define the matrices here but it would be better if they 
// could be made static.  

FUNCTION dvariable SSB_Recruitment_loglikeli()
  // logSSBmax is in reality 5 times  the  spawing stock giving 1/2 maximum recruitment if Beverton 
  // and holt.  Therefore logSSBmax/5 in the relationship.
  // N1 and PredN_1 eru fjöldi fiska 0 ára.  

  int ssbRecyrs = nyrs+nsimuyrs-firstage;
  int ssbRecdatayrs = nyrs - firstage;
  int i = 0;
  int j = 0; 
  dvariable tmpssb;  // temporary variable
  dvariable minssb = 0.4; // SSB beoynd which cv is independent 
  dvariable maxssb = 2.5; // of ssb
  dvariable spawnlnDet;
  dvariable sign;
  dvar_vector tmprecr(1,ssbRecyrs);
  dvar_matrix spawncorrmatrix(1,nyrs+nsimuyrs-firstage,1,nyrs+nsimuyrs-firstage);
  dvar_vector relspawn(1,ssbRecyrs);  // SSB/500 in some power

  for(i = 1; i <= ssbRecyrs ; i++) 
   relspawn(i) = pow(SmoothDamper(Spawningstock(i)/500.0,maxssb,minssb),Spawnpowest);
 
  PredNfromSSB();

  // Calculate spawncorrmatrix. Do not have to do it every step 
  // if spawnpow =  0;
  for(i = 1; i <= ssbRecyrs ;i++){
     spawncorrmatrix(i,i) = 1/relspawn(i);
     for( j = 1; j < i; j++) {
       spawncorrmatrix(i,j) = pow(Spawncorrest,i-j)/sqrt(relspawn(i)*relspawn(j));
       spawncorrmatrix(j,i) = spawncorrmatrix(i,j);
     }
  }

  for(i = 1; i <= ssbRecyrs ;i++)
    N_1(i) = N(i+firstage,1);
  resid_1 = log(predN_1)-log(N_1);
  tmprecr  = solve(spawncorrmatrix,resid_1,spawnlnDet,sign);

//   Note that SpawnCv is multiplied by nyrs-firstage SpawnlnDet needs probably
//   Similar treadment

   return 0.5*spawnlnDet+log(SpawnCvest)*(nyrs-firstage)+0.5*resid_1*tmprecr/(SpawnCvest*SpawnCvest);


FUNCTION dvariable SSB_Recruitment_loglikeli_nocorr()
  // logSSBmax is in reality 5 times  the  spawing stock giving 1/2 maximum recruitment if Beverton 
  // and holt.  Therefore logSSBmax/5 in the relationship.
  // N1 and PredN_1 eru fjöldi fiska 0 ára.  
  dvariable value;
  dvariable wts = 0.2;
  int ssbRecyrs = nyrs+nsimuyrs-firstage;
  int ssbRecdatayrs = nyrs - firstage;
  int i = 0;
  int j = 0; 
  dvariable minssb = 0.4; // SSB beoynd which cv is independent 
  dvariable maxssb = 2.5; // of ssb
  dvar_vector SigmaSSBRecr(1,ssbRecyrs);  // SSB/500 in some power

  PredNfromSSB();
  dvariable RefSSB = Spawningstock(1972-firstyear+1);  // Approx 500 thous tonnes
  for(i = 1; i <= ssbRecyrs ; i++) 
    SigmaSSBRecr(i) = SpawnCvest/pow(SmoothDamper(Spawningstock(i)/RefSSB,maxssb,minssb),Spawnpowest); 
// Special only for cod
  value = 0;
  for(i = nyrs-4; i <= ssbRecdatayrs ; i++)
    value += log(SigmaSSBRecr(i))+0.5*square(resid_1(i)/SigmaSSBRecr(i));
  value = value*wts; // Reduced weight on last 4.  
  for(i = 1; i <= nyrs-5;i++)
    value += log(SigmaSSBRecr(i))+0.5*square(resid_1(i)/SigmaSSBRecr(i));
  for(i =  ssbRecdatayrs+1; i <= ssbRecyrs; i++) 
    value +=   0.5*square(resid_1(i)/SigmaSSBRecr(i));
  return(value);
//  return sum(log(SigmaSSBRecr(1,ssbRecdatayrs)))+0.5*sum(square(elem_div(resid_1,SigmaSSBRecr)));
// Function that calculates predicted rectcruitment from spawning stock
  


FUNCTION PredNfromSSB 
  int ssbRecyrs = nyrs+nsimuyrs-firstage;
  int ssbRecdatayrs = nyrs - firstage;
  int i = 0;
  int j = 0; 
  dvar_vector matN(a1,nages);
  dvariable sumN; // temporary variable
  dvariable tmpssb;  // temporary variable
  dvariable Rmax = mfexp(logRmax); 
  dvariable SSBmax = mfexp(logSSBmax);
  dvar_vector feuc(1,ssbRecyrs);  // feucundity 
  dvar_vector TimeDrift(1,ssbRecyrs);
  TimeDrift(1) = 0; 
  for(i = 2; i <= ssbRecyrs ;i++) {     
    if(i <= nyrs -5 ) TimeDrift(i) = TimeDrift(i-1) + RecrDrift(1); 
    if( i > nyrs - 5) TimeDrift(i) = TimeDrift(i-1);
   }
// Calculate Shannon index.  Used in some SSB-recruitment functions.
// matN should in reality be called matBio at least in this version  
   for(i = 1; i <= ssbRecyrs ;i++){
      matN = elem_prod( elem_prod(N(i)(a1,nages),StockSexMat(i)), ssbWts(i) ); //thg
      sumN = sum(matN); //thg shannon
      Shannon(i) = log(sumN)-sum(elem_prod(matN,log(matN+0.0001)))/sumN; //thg
   }
   Shannon -= sum(Shannon)/ssbRecyrs; 

// Drift up to nyrs - 3 ala GG
//   dvariable RecrDrift = 0.00;  // timedrift
   Rmax = mfexp(logRmax);
   SSBmax = mfexp(logSSBmax);
// Drift stops after nyrs.
   if(SSBRectype == 1) {
     for(i = 1; i <= ssbRecyrs ;i++)
        predN_1(i) = Rmax*mfexp(-TimeDrift(i))*Spawningstock(i)/
        (SSBmax/5.0+Spawningstock(i));
   }
   // Ricker.  Here logSSBmax exists.  
   if(SSBRectype == 2) {
   for(i = 1; i <= ssbRecyrs ;i++)
       predN_1(i) = Rmax*mfexp(-TimeDrift(i))*mfexp(1.0)/SSBmax*Spawningstock(i)*mfexp(-Spawningstock(i)/SSBmax);
   }   
   if(SSBRectype == 3) {  // Ricker + Shannon  THG gefur verra fit en 4.  
     for(i = 1; i <= ssbRecyrs ;i++)
       predN_1(i) = Rmax*mfexp(1.0)/SSBmax*Spawningstock(i)*mfexp(-Spawningstock(i)/SSBmax)*mfexp(dSha*Shannon(i));
   }
   if(SSBRectype == 4) {  // Ricker + Shannon  other type dSha mjög illa metinn
     for(i = 1; i <= ssbRecyrs ;i++){
       tmpssb = Spawningstock(i)*dSha*mfexp(Shannon(i));
       predN_1(i) = Rmax*mfexp(-TimeDrift(i))*mfexp(1.0)/SSBmax*tmpssb*
	 mfexp(-tmpssb/SSBmax);
     }
   }
// Eggjaframleiðslu út frá rallgögnum nota ssbwt.  4.3e-6 er reiknað 
// úr rallgögnum en mat er 2e-6 á hlutfallinu eggjafr/biomassi vs þyngd
// gefur svipað fit og ricker spawncvest = 0.37,spawnpow=0.15 og spawncorr=0.13
// Í fyrstu umferð gleymdist sennilega að margfalda með kynþroska og stilla
// greiningu úr rallgögnum á samsvarandi hátt.  


   if(SSBRectype == 5) {      
     for(i = 1; i <= ssbRecyrs ;i++){
       tmpssb = 0;
       for(j = a1 ; j <= nages; j++)
	  tmpssb += N(i,j)*StockSexMat(i,j)*ssbWts(i,j)*ssbWts(i,j)*fecunditymultiplier*
	  mfexp(-(natM(i,j)*PropofMbeforeSpawning(j)+F(i,j)*PropofFbeforeSpawning(j)));
       tmpssb /= 1e12;
       tmpssb *= 50; // to be able to use Ricker or BH
       feuc(i) = tmpssb;
       predN_1(i) = Rmax*mfexp(1.0)/SSBmax*Spawningstock(i)*mfexp(-Spawningstock(i)/SSBmax);
     }   
   }
// Fixed mean 
   if(SSBRectype == 6) {
   for(i = 1; i <= ssbRecyrs ;i++)
       predN_1(i) = Rmax*mfexp(-TimeDrift(i));
   }   



   for(i = 1; i <= ssbRecyrs ;i++)
     N_1(i) = N(i+firstage,1);
   resid_1 = log(predN_1)-log(N_1);

// Errors in weight.  Move in preliminary calc section

FUNCTION WeightCorr; 
  int i; 
  int j;
  dvar_matrix wtcorrmatrix(1,nsimuyrs,1,nsimuyrs);
  dvariable logdet;
  dvariable SigmaWt = 0.1;
  dvariable Wtcorr = 0.35;
  for(i = 1; i <= nsimuyrs ;i++){
     wtcorrmatrix(i,i) = 1;
     for( j = 1; j < i; j++) {
       wtcorrmatrix(i,j) = pow(Wtcorr,i-j);
       wtcorrmatrix(j,i) = wtcorrmatrix(i,j);
     }
  }  
  wtcorrmatrix  = wtcorrmatrix*square(SigmaWt);
  logdet = log(det(wtcorrmatrix));
  wtcorrmatrix = inv(wtcorrmatrix);
  LnLikelicomp(9) = 0.5*logdet+0.5*Weighterr*wtcorrmatrix*Weighterr;
  
//***********************************************************
// CatchRule which is to specify the catch; // Comment assessmenterror out in this case.  

FUNCTION SpecifiedCatch
  dvariable SigmaImpl = 0.05; // ImplementationCV  in CatchRule low.  
  LnLikelicomp(7) = 0;  // No assessment error involved
  LnLikelicomp(8) = 0;
  int i;
// Use "real catch in retros") 
  if(retroyears > 0) {
    for(i = nyrs+1; i <= min(nyrs+nsimuyrs,nyrs+retroyears); i++) 
      LnLikelicomp(8) += square(log(CalcCatchIn1000tons(i))-log(CatchIn1000tonsforRetro(i)))/(2.*square(SigmaImpl)) + log(SigmaImpl);
    if(nyrs + nsimuyrs > ndatayrs)
      for(i = nyrs+retroyears+1; i <= nyrs+nsimuyrs; i++) 
        LnLikelicomp(8) += square(log(CalcCatchIn1000tons(i))-log(FutureCatch(i-retroyears)))/(2.*square(SigmaImpl)) + log(SigmaImpl);
  }
  else  // not retro.   
    for(i = nyrs+1; i <= nyrs+nsimuyrs; i++) 
     LnLikelicomp(8) += square(log(CalcCatchIn1000tons(i))-log(FutureCatch(i)))/(2.*square(SigmaImpl)) + log(SigmaImpl);


// *************************-------------------------*********************    
FUNCTION IceCodHarvestrule
  LnLikelicomp(8) = 0;
  int j = 0; 
  dvariable assesslnDet;
  dvariable sign;
  dvariable minssb = 0.4; // SSB beoynd which assessmentcv is independent 
  dvariable maxssb = 2.5; // of ssb
  int i = 0;
  int ssbRecyrs = nyrs+nsimuyrs-firstage;
  dvar_matrix assessmentcorrmatrix(1,nsimuyrs,1,nsimuyrs);
  dvar_vector relspawn(1,nsimuyrs);  // SSB/500 in some power
  dvar_vector tmperr(1,nsimuyrs);  
  // if assessment error depends on stock size.  
  for(i = 1; i <= nsimuyrs ; i++) 
    relspawn(i) = pow(SmoothDamper(Spawningstock(i+nyrs)/500,maxssb,minssb),Assessmentpow); 
    
// Calculate assessmentcorrmatrix. Do not have to do it every step 
// if assessmentpow = 0

  for(i = 1; i <= nsimuyrs ;i++){
     assessmentcorrmatrix(i,i) = 1/relspawn(i);
     for( j = 1; j < i; j++) {
       assessmentcorrmatrix(i,j) = pow(Assessmentcorr,i-j)/sqrt(relspawn(i)*relspawn(j));
       assessmentcorrmatrix(j,i) = assessmentcorrmatrix(i,j);
     }
  }
//* comment out if assessment err is not included.  
 tmperr  = solve(assessmentcorrmatrix,Assessmenterr,assesslnDet,sign);
  LnLikelicomp(7) = 0.5*assesslnDet+log(CvAssessment)*nsimuyrs+0.5*Assessmenterr*tmperr/(CvAssessment*CvAssessment);
//  LnLikelicomp(7) = 0;

  dvariable refcatch;
  dvariable SigmaImpl = 0.05; // ImplementationCV  in CatchRule low.  
  for(i = nyrs+1; i <= nyrs + nsimuyrs; i++) {
    refcatch =AssessmentBias*HarvestProportion*(Cbio2(i));
    refcatch = mfexp(log(refcatch)+Assessmenterr(i-nyrs));  // Put the error on refcatch;
    if(i == (nyrs+1)) refcatch = (LastYearsTac+refcatch)/2;
    if(i > (nyrs+1)) refcatch =  (FishingYearCatch(i-1) +refcatch)/2;

    if(NextYearsTac > 0 && i == nyrs+1 ) refcatch = NextYearsTac;  // Sometimes without error next year
    FishingYearCatch(i) = refcatch;
  }
  
  refcatch = QuotaLeft+FishingYearCatch(nyrs+1)/3;  // First simu year.
  LnLikelicomp(8) += square(log(CalcCatchIn1000tons(nyrs+1))-log(refcatch))/(2.*square(SigmaImpl)) + log(SigmaImpl);  
  for(i = nyrs+2; i <= nyrs + nsimuyrs; i++) {  
    if(i == nyrs + nsimuyrs) refcatch = FishingYearCatch(i); 
    else  refcatch = FishingYearCatch(i)/3+ 
			     FishingYearCatch(i-1)*2/3;  // was (i+1)
    LnLikelicomp(8) += square(log(CalcCatchIn1000tons(i))-log(refcatch))/(2.*square(SigmaImpl)) + log(SigmaImpl);
  }


// For bayesian runs print out every 100 time. 
FUNCTION BayesPrint 
  if(printcounter == 100) {
    int i; 
    ofstream outfile; 
    outfile.open("result",ios::app);
    for( i = nyrs-6; i <= nyrs+nsimuyrs; i++) {
      outfile << firstyear+i-1 << " "<< Spawningstock(i) 
      << " " << mfexp(lnEffort(i)) << " "<<  N(i,1) << " " 
      << N(i,3) << " " << CbioR(i) << " " 
      << Cbio2(i) << " " << CalcCatchIn1000tons(i) 
      << " " << RefF(i) << endl;
     printcounter = 1;
     }
     outfile << "-1 -1 -1 -1 -1 -1 -1 -1 -1 " << endl;
     outfile.close();
 }



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







REPORT_SECTION
  report << "scorr " <<endl <<  inv(Scorrmat) << endl; 


  // Mostly output to matrices.  
  report << "nyrs " << nyrs << endl;
  report << "ndatayrs " << ndatayrs << endl;
  report << "lastyear " << firstyear+nyrs-1 << endl;

  report << "CalcSurveyNr " << endl  << CalcSurveyNr << endl ;
  report << "ObsSurveyNr " << endl  << ObsSurveyNr << endl ;
  report << "SurveylnQ " << mfexp(SurveylnQ) << endl;
  report << "SurveyPowerest " << SurveyPowerest << endl;

  report << "predN_1 " << endl << predN_1 << endl;
  report << "N_1 " << endl <<  N_1 << endl;
//  report << " a50 " << a50 << endl;
  report << " meansel " << meansel << endl;
//  report << "SigmaEffort " << mfexp(lnSigmaEffort) << endl;
//  report <<  "Sigmaa50 " << mfexp(lnSigmaa50) < endl;
  report << "SigmaC " << endl << SigmaC << endl;
  report << "SigmaSurvey " << endl << SigmaSurvey*sqrt(mfexp(logSigmaSurveypar)) << endl;
  report << "Estimated numbers of fish " << endl;  report << N << endl;
  report << "Estimated numbers in catch " << endl;
  report << CalcCatchInNumbers << endl;
  report << "Observed numbers in catch " << endl;
  report << ObsCatchInNumbers << endl; 
  report << "Lnlikeli " << endl;
  report << LnLikelicomp << endl;
  report << "CatchIn1000tons " << endl << CatchIn1000tons << endl;  
  report << "CalcCatchIn1000tons " << endl << CalcCatchIn1000tons << endl;
  report << "Spawningstock " << endl << Spawningstock << endl;
  report << "Cbio2 " << endl << Cbio2 << endl;
  report << "CbioR " << endl << CbioR << endl;
  report << "Shannon " << Shannon << endl;

  report << "Estimated fishing mortality " << endl  << F << endl; 


// output in column oriented format. Need to include things not available for all years like survey data.  
// -1 put in the file when data are notvailable.   

   int j = 0;
   int i = 0;
//  Recalculate survey values for all years
 for( i = 1; i <= nyrs+nsimuyrs ; i++) {
    for(j = surveyfirstagenr; j <= surveylastagenr; j++) {
     pZ = SurveyPropOfF*F(i,j)+SurveyPropOfM*natM(i,j);
     if(i >= surveyfirstyearnr && i <= surveylastyearnr) 
       CalcSurveyNr(i,j) = mfexp(log(N(i,j)*mfexp(-pZ))*SurveyPower(j)+SurveylnQ(j)+SurveylnYeareffect(i));
      else 
        CalcSurveyNr(i,j) = mfexp(log(N(i,j)*mfexp(-pZ))*SurveyPower(j)+SurveylnQ(j));
    }
    CalcSurveybio(i) = sum(elem_prod(CalcSurveyNr(i),StockWts(i)(surveyfirstagenr,surveylastagenr)))/1000;
  }



   ofstream outfile("resultsbyyear"); 
   outfile << "year \t annualF \t F5-10\t calccatch \t SSB \tOldSSB\t CbioR \t Cbio4+ \t Cbio1  \t N1 \t N3 \t N6 \tHarvestRatio \t obscatch \t a50 \t CalcSurveybio \t Obssurveybio \t CalcSurvey2bio \t Obssurvey2bio \t PredN \t FishingYearCatch" << endl;
   for(i = 1; i <= nyrs+nsimuyrs ; i++) {
       outfile << firstyear+i-1 <<"\t"<< "-1" << "\t" << RefF(i) << "\t" << CalcCatchIn1000tons(i) << "\t" << Spawningstock(i) << "\t" << OldSpawningstock(i) <<  "\t" << CbioR(i) <<  "\t" << Cbio2(i) << "\t" << Cbio1(i) << "\t" << N(i,1) <<  "\t" <<  N(i,3) <<  "\t"  << N(i,6) <<  "\t" << HarvestRatio(i) << "\t" ;
       if(i <= nyrs ) 
          outfile <<  CatchIn1000tons(i) <<  "\t" << "a50(i)" << "\t";
       else 
          outfile <<  "-1\t-1\t";
       outfile << CalcSurveybio(i) << "\t";
       if(i >= surveyfirstyearnr && i <= surveylastyearnr) 
          outfile << ObsSurveybio(i) << "\t";
       else 
          outfile << "-1" << "\t";
       outfile << CalcSurvey2bio(i) << "\t";
       if(i >= survey2firstyearnr && i <= survey2lastyearnr) 
          outfile << ObsSurvey2bio(i) << "\t";
       else 
          outfile << "-1" << "\t";
       if(i > firstage) 
	  outfile << predN_1(i-firstage) << "\t";
       else 
	  outfile << "-1" << "\t";
       if(i > nyrs) 
	  outfile << FishingYearCatch(i) << endl; 
       else 
	  outfile << "-1" << endl;
   }
   outfile.close();

 
   outfile.open("resultsbyage");
 
  outfile << "age \t M \t surveysigma \t SurveylnQ \t SurveyPower \t survey2sigma \t Survey2lnQ \t Survey2Power  \tmeansel \tprogsel\tsigma"<< endl ;
  for(i = 1; i <= nages; i++) {
    outfile << i+firstage-1 << "\t" << M1(i) << "\t";
    if(i >= surveyfirstagenr && i <= surveylastagenr) 
       outfile  << SigmaSurvey(i)*sqrt(mfexp(logSigmaSurveypar)) << "\t" << SurveylnQ(i) << "\t" <<  SurveyPower(i)  << "\t";
    else
       outfile << "-1\t-1\t-1\t";
    if(i >= survey2firstagenr && i <= survey2lastagenr) 
       outfile  << SigmaSurvey2(i)*sqrt(mfexp(logSigmaSurvey2par)) << "\t" << Survey2lnQ(i) << "\t" <<  Survey2Power(i)  << "\t";
    else
       outfile << "-1\t-1\t-1\t";
    if(i >= a1) 
       outfile << meansel(i) << "\t" << progsel(i) << "\t" <<  SigmaC(i) <<  endl;
    else 
       outfile << "-1\t-1\t-1" << endl;
  }
  outfile.close();
 
 
    outfile.open("resultsbyyearandage");
    outfile << "year \t age \t N  \t Z \t StockWts \t M \t F \t CalcCno \t CatchWts \t SSBwts \t StockSexmat \tCatchSexmat\t ObsCno \tCalcSurveyNr \tObsSurveyNr\tSurveyDiff\t CalcSurvey2Nr \t ObsSurvey2Nr\t Survey2Diff \tSSB" << endl;
    for(i = 1; i <= nyrs+nsimuyrs; i++) {
      for(j = 1; j <= nages; j++) {
        outfile << firstyear+i-1 << "\t" << firstage+j-1 << "\t" << N(i,j) << "\t" << Z(i,j) << "\t" << StockWts(i,j) << "\t" << natM(i,j) << "\t";

        if(j >= a1) 
	  outfile << F(i,j) << "\t" << CalcCatchInNumbers(i,j) << "\t" << CatchWts(i,j) << "\t" << ssbWts(i,j) << "\t" <<  StockSexMat(i,j) << "\t" <<  CatchSexMat(i,j) << "\t";
        else 
	  outfile << "-1\t-1\t-1\t-1\t-1\t-1\t";

        if(i <= nyrs && j >= a1) 
	  outfile << ObsCatchInNumbers(i,j) << "\t";
	else 
	  outfile << "-1\t";
        if(j >= surveyfirstagenr && j <= surveylastagenr) 
	   outfile << CalcSurveyNr(i,j) << "\t";
        else 
	   outfile << "-1\t";
        if(j >= surveyfirstagenr && j <= surveylastagenr && i >= surveyfirstyearnr && i <= surveylastyearnr) 
	   outfile <<  ObsSurveyNr(i,j) << "\t" << RSsurveydiff(i,j) << "\t";
        else 
	   outfile << "-1\t-1\t";
        if(j >= survey2firstagenr && j <= survey2lastagenr) 
	   outfile << "\t" <<  CalcSurvey2Nr(i,j) << "\t";
        else 
	   outfile << "\t -1\t";
       if(j >= survey2firstagenr && j <= survey2lastagenr && i >= survey2firstyearnr && i <= survey2lastyearnr) 
	   outfile <<  ObsSurvey2Nr(i,j) << "\t" << RSsurvey2diff(i,j) << "\t";
        else 
	   outfile << "-1\t-1" << "\t";

        if(j >= a1) 
           outfile << SSBbyage(i,j) << endl; 
        else 
           outfile << "-1" << endl;
        
      }
    }
    outfile.close() ;


    outfile.open("likelivalues");
    outfile << LnLikelicomp << endl;
    outfile << Likeliweights << endl;
    outfile << LnLikely << endl;

//Fishing mortality as function of year and age
//Fallið er effort*







 





 

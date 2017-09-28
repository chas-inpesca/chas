#ifdef DEBUG
  #ifndef __SUNPRO_C
    #include <cfenv>
    #include <cstdlib>
  #endif
#endif
 #include <admodel.h>
  adstring datafile_name;
  adstring ctlfile_name;
  /**
  \def ECHO(object)
  Prints name and value of \a object on echoinput %ofstream file.
  */
  #undef ECHO
  #define ECHO(object) echoinput << #object << "\n" << object << endl;
  ofstream echoinput("checkfile.rep");
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <em.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
 *(ad_comm::global_datafile) >>  datafile_name; // First line is datafile 
 *(ad_comm::global_datafile) >>  ctlfile_name; // First line is datafile 
ad_comm::change_datafile_name(datafile_name);
  styr.allocate("styr");
  endyr.allocate("endyr");
  nages.allocate("nages");
  catch_bio.allocate(styr,endyr,"catch_bio");
  nobs_cpue.allocate("nobs_cpue");
  yr_cpue.allocate(1,nobs_cpue,"yr_cpue");
  obs_cpue.allocate(1,nobs_cpue,"obs_cpue");
  nobs_surv.allocate("nobs_surv");
  yr_surv.allocate(1,nobs_surv,"yr_surv");
  obs_surv.allocate(1,nobs_surv,"obs_surv");
  nobs_survpel.allocate("nobs_survpel");
  yr_survpel.allocate(1,nobs_survpel,"yr_survpel");
  obs_survpel.allocate(1,nobs_survpel,"obs_survpel");
  nlenbins.allocate("nlenbins");
  nobs_fishlen.allocate("nobs_fishlen");
  yr_fishlen.allocate(1,nobs_fishlen,"yr_fishlen");
  yr_fishlenreclas.allocate(1,nobs_surv,"yr_fishlenreclas");
  yr_fishlenpelaces.allocate(1,nobs_survpel,"yr_fishlenpelaces");
  obs_p_len.allocate(1,nobs_fishlen,1,nlenbins,"obs_p_len");
  obs_p_lenreclas.allocate(1,nobs_surv,1,nlenbins,"obs_p_lenreclas");
  obs_p_lenpelaces.allocate(1,nobs_survpel,1,nlenbins,"obs_p_lenpelaces");
  wta.allocate(styr,endyr,1,nages,"wta");
    ECHO(styr);
    ECHO(endyr);
    ECHO(nages);  
    ECHO(catch_bio);  
    ECHO(nobs_cpue);
    ECHO(yr_cpue);
    ECHO(obs_cpue);
    ECHO(nobs_surv);
    ECHO(yr_surv);
    ECHO(obs_surv);
    ECHO(nobs_survpel);
    ECHO(yr_survpel);
    ECHO(obs_survpel);
    ECHO(nlenbins );
    ECHO(nobs_fishlen);
    ECHO(yr_fishlen);                               
    ECHO(yr_fishlenreclas);                             
    ECHO(yr_fishlenpelaces);   
    ECHO(obs_p_len);              
    ECHO(obs_p_lenreclas);          
    ECHO(obs_p_lenpelaces);  
    ECHO(wta);                                     
ad_comm::change_datafile_name(ctlfile_name);
  ph_sel_fish.allocate("ph_sel_fish");
  shif_r.allocate("shif_r");
  h.allocate("h");
  crecimiento.allocate(1,5,"crecimiento");
  opt_VB.allocate("opt_VB");
  nlen_fish.allocate("nlen_fish");
  nlen_fishr.allocate("nlen_fishr");
  nlen_fishp.allocate("nlen_fishp");
  CV_surv.allocate("CV_surv");
  CV_survpel.allocate("CV_survpel");
  CV_catch.allocate("CV_catch");
  CV_cpue.allocate("CV_cpue");
  ph_M.allocate("ph_M");
  ph_sigmar.allocate("ph_sigmar");
  ph_Fdev.allocate("ph_Fdev");
  ph_recdev.allocate("ph_recdev");
  ph_q.allocate("ph_q");
  ph_qsurv.allocate("ph_qsurv");
  ph_qsurvpel.allocate("ph_qsurvpel");
  natmortprior.allocate("natmortprior");
  cvnatmortprior.allocate("cvnatmortprior");
  qprior.allocate("qprior");
  cvqprior.allocate("cvqprior");
  edad.allocate(1,nages,"edad");
  len.allocate(1,nlenbins,"len");
  avgL.allocate(1,nages,"avgL");
  obs_CV.allocate(1,nages,"obs_CV");
  wt.allocate(1,nages,"wt");
  wti.allocate(1,nages,"wti");
  fecha_desov.allocate("fecha_desov");
 SpawnMo_Frac = fecha_desov / 12;
  fecha_reclas.allocate("fecha_reclas");
 reclasMo_Frac = fecha_reclas / 12;
  fecha_pelaces.allocate("fecha_pelaces");
 pelacesMo_Frac = fecha_pelaces / 12;
  maturity.allocate(1,nages,"maturity");
  nselagef1.allocate("nselagef1");
  group_num_f1.allocate("group_num_f1");
  ph_sel_fish1.allocate("ph_sel_fish1");
  ph_seldev_f1.allocate("ph_seldev_f1");
  lambda.allocate(1,3,"lambda");
  linf.allocate("linf");
  k1.allocate("k1");
  ECHO(ph_sel_fish);
  ECHO(shif_r);
  ECHO(h);
  ECHO(crecimiento);
  ECHO(opt_VB);
  ECHO(nlen_fish  );
  ECHO(nlen_fishr );
  ECHO(nlen_fishp );  
  ECHO(CV_surv    );
  ECHO(CV_survpel );
  ECHO(CV_catch   );
  ECHO(CV_cpue    );
  ECHO(ph_M       );
  ECHO(ph_sigmar  );
  ECHO(ph_Fdev    );
  ECHO(ph_recdev  );
  ECHO(ph_q       );
  ECHO(ph_qsurv   );
  ECHO(ph_qsurvpel);
  ECHO(natmortprior);
  ECHO(cvnatmortprior);
  ECHO(qprior);
  ECHO(cvqprior);
  ECHO(edad);
  ECHO(len);
  ECHO(avgL);
  ECHO(obs_CV);
  ECHO(wt);
  ECHO(maturity);
  ECHO(nselagef1      );  
  ECHO(group_num_f1  );
  ECHO(ph_sel_fish1   );
  ECHO(ph_seldev_f1   );
  ECHO(lambda    );
  //ECHO(linf);//Linfdat Modificado
  //ECHO(k);//kdat
  //ECHO(to)//;t0dat
  //ECHO();Cdat  // CG eliminado
  //ECHO();Tsdat 
  int if1=0;
  for (int i=styr;i<endyr;i++)
  {
  if(!(i%group_num_f1))
  {
  if1++;
  }
  }
  dim_sel_f1=if1;
  
  styr_rec=styr-nages+1;
  styr_fut=endyr+1;
  endyr_fut=styr_fut+5;
  phase_F40=5;
  MLE_catch.allocate(1,5,styr_fut,endyr_fut,"MLE_catch");
}

void model_parameters::initializationfunction(void)
{
  M.set_initial_value(0.96);
  mean_log_rec1.set_initial_value(18);
  mean_log_rec.set_initial_value(18);
  log_Nini.set_initial_value(15);
  log_avg_fmort.set_initial_value(-3.5);
  log_q_cpue.set_initial_value(-2.);
  log_q_surv.set_initial_value(-0.001);
  log_q_survpel.set_initial_value(-0.001);
  sigr.set_initial_value(0.6);
  log_Bo.set_initial_value(8.45);
  a50.set_initial_value(.2);
  a95.set_initial_value(1.8);
  a50p.set_initial_value(.2);
  a95p.set_initial_value(1.5);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  M.allocate(0.3,1.7,ph_M,"M");
  log_Lo.allocate(1,2.1,-1,"log_Lo");
  log_cv_edad.allocate(-4,-1.8,-1,"log_cv_edad");
  C.allocate(0.1,1,-1,"C");
  Ts.allocate(0.1,1.0,-1,"Ts");
  sigr.allocate(0.55,1,ph_sigmar,"sigr");
  log_P.allocate(-4,0,-2,"log_P");
  a50.allocate(-4,4,ph_sel_fish,"a50");
  a95.allocate(0.1,7.,ph_sel_fish,"a95");
  a50p.allocate(-4,4,ph_sel_fish,"a50p");
  a95p.allocate(0.1,7,ph_sel_fish,"a95p");
  F60.allocate(.01,2.,phase_F40,"F60");
  F40.allocate(.01,2.,phase_F40,"F40");
  F20.allocate(.01,2.,phase_F40,"F20");
  log_Bo.allocate(4,12,-2,"log_Bo");
  rec_dev_future.allocate(styr_fut,endyr_fut,-20.,20.,ph_recdev,"rec_dev_future");
  cv_age.allocate(1,nages,0.02,0.18,-1,"cv_age");
  fmort_dev.allocate(styr,endyr,-10,10,ph_Fdev,"fmort_dev");
  log_dev_ini.allocate(2,nages,-10,10,1,"log_dev_ini");
  rec_dev.allocate(styr,endyr,-20,20,ph_recdev,"rec_dev");
  sel_devs_f1.allocate(1,dim_sel_f1,1,4,-5.,5.,ph_seldev_f1,"sel_devs_f1");
  log_selcoffs_f1.allocate(1,nselagef1,ph_sel_fish1,"log_selcoffs_f1");
  log_q_surv.allocate(ph_qsurv,"log_q_surv");
  log_q_cpue.allocate(ph_q,"log_q_cpue");
  log_q_survpel.allocate(ph_qsurvpel,"log_q_survpel");
  mean_log_rec1.allocate(1,"mean_log_rec1");
  mean_log_rec.allocate(1,"mean_log_rec");
  log_Nini.allocate(1,"log_Nini");
  log_avg_fmort.allocate(1,"log_avg_fmort");
  avgsel_fish1.allocate("avgsel_fish1");
  #ifndef NO_AD_INITIALIZE
  avgsel_fish1.initialize();
  #endif
  diff.allocate("diff");
  #ifndef NO_AD_INITIALIZE
  diff.initialize();
  #endif
  Rlast.allocate("Rlast");
  #ifndef NO_AD_INITIALIZE
  Rlast.initialize();
  #endif
  Rmedio.allocate("Rmedio");
  #ifndef NO_AD_INITIALIZE
  Rmedio.initialize();
  #endif
  Prec.allocate("Prec");
  #ifndef NO_AD_INITIALIZE
  Prec.initialize();
  #endif
  sigmar.allocate("sigmar");
  #ifndef NO_AD_INITIALIZE
  sigmar.initialize();
  #endif
  ftmp.allocate("ftmp");
  #ifndef NO_AD_INITIALIZE
  ftmp.initialize();
  #endif
  SB0.allocate("SB0");
  #ifndef NO_AD_INITIALIZE
  SB0.initialize();
  #endif
  SBF60.allocate("SBF60");
  #ifndef NO_AD_INITIALIZE
  SBF60.initialize();
  #endif
  SBF40.allocate("SBF40");
  #ifndef NO_AD_INITIALIZE
  SBF40.initialize();
  #endif
  SBF20.allocate("SBF20");
  #ifndef NO_AD_INITIALIZE
  SBF20.initialize();
  #endif
  surv.allocate("surv");
  #ifndef NO_AD_INITIALIZE
  surv.initialize();
  #endif
  Fmsylast.allocate("Fmsylast");
  #ifndef NO_AD_INITIALIZE
  Fmsylast.initialize();
  #endif
  q_fish.allocate("q_fish");
  #ifndef NO_AD_INITIALIZE
  q_fish.initialize();
  #endif
  q_surv.allocate("q_surv");
  #ifndef NO_AD_INITIALIZE
  q_surv.initialize();
  #endif
  q_survpel.allocate("q_survpel");
  #ifndef NO_AD_INITIALIZE
  q_survpel.initialize();
  #endif
  rec_like.allocate("rec_like");
  #ifndef NO_AD_INITIALIZE
  rec_like.initialize();
  #endif
  cvage_like.allocate("cvage_like");
  #ifndef NO_AD_INITIALIZE
  cvage_like.initialize();
  #endif
  catch_like.allocate("catch_like");
  #ifndef NO_AD_INITIALIZE
  catch_like.initialize();
  #endif
  age_like.allocate("age_like");
  #ifndef NO_AD_INITIALIZE
  age_like.initialize();
  #endif
  age_liker.allocate("age_liker");
  #ifndef NO_AD_INITIALIZE
  age_liker.initialize();
  #endif
  age_likep.allocate("age_likep");
  #ifndef NO_AD_INITIALIZE
  age_likep.initialize();
  #endif
  sel_like.allocate("sel_like");
  #ifndef NO_AD_INITIALIZE
  sel_like.initialize();
  #endif
  sel_dev_like.allocate("sel_dev_like");
  #ifndef NO_AD_INITIALIZE
  sel_dev_like.initialize();
  #endif
  fpen.allocate("fpen");
  #ifndef NO_AD_INITIALIZE
  fpen.initialize();
  #endif
  cpue_like.allocate("cpue_like");
  #ifndef NO_AD_INITIALIZE
  cpue_like.initialize();
  #endif
  surv_like.allocate("surv_like");
  #ifndef NO_AD_INITIALIZE
  surv_like.initialize();
  #endif
  surv_likepel.allocate("surv_likepel");
  #ifndef NO_AD_INITIALIZE
  surv_likepel.initialize();
  #endif
  cv_edad.allocate("cv_edad");
  #ifndef NO_AD_INITIALIZE
  cv_edad.initialize();
  #endif
  k.allocate("k");
  #ifndef NO_AD_INITIALIZE
  k.initialize();
  #endif
  Lo.allocate("Lo");
  #ifndef NO_AD_INITIALIZE
  Lo.initialize();
  #endif
  BPRo.allocate("BPRo");
  #ifndef NO_AD_INITIALIZE
  BPRo.initialize();
  #endif
  log_Ro.allocate("log_Ro");
  #ifndef NO_AD_INITIALIZE
  log_Ro.initialize();
  #endif
  alfa.allocate("alfa");
  #ifndef NO_AD_INITIALIZE
  alfa.initialize();
  #endif
  beta1.allocate("beta1");
  #ifndef NO_AD_INITIALIZE
  beta1.initialize();
  #endif
  beta2.allocate("beta2");
  #ifndef NO_AD_INITIALIZE
  beta2.initialize();
  #endif
  offset.allocate("offset");
  #ifndef NO_AD_INITIALIZE
  offset.initialize();
  #endif
  offsetr.allocate("offsetr");
  #ifndef NO_AD_INITIALIZE
  offsetr.initialize();
  #endif
  sprpen.allocate("sprpen");
  #ifndef NO_AD_INITIALIZE
  sprpen.initialize();
  #endif
  bmsy.allocate("bmsy");
  #ifndef NO_AD_INITIALIZE
  bmsy.initialize();
  #endif
  rbmsylast.allocate("rbmsylast");
  #ifndef NO_AD_INITIALIZE
  rbmsylast.initialize();
  #endif
  avg_rec_dev_future.allocate("avg_rec_dev_future");
  #ifndef NO_AD_INITIALIZE
  avg_rec_dev_future.initialize();
  #endif
  offsetp.allocate("offsetp");
  #ifndef NO_AD_INITIALIZE
  offsetp.initialize();
  #endif
  So.allocate("So");
  #ifndef NO_AD_INITIALIZE
  So.initialize();
  #endif
  sumtmp.allocate("sumtmp");
  #ifndef NO_AD_INITIALIZE
  sumtmp.initialize();
  #endif
  sigmar_fut.allocate("sigmar_fut");
  #ifndef NO_AD_INITIALIZE
  sigmar_fut.initialize();
  #endif
  Kobs_tot_catch.allocate("Kobs_tot_catch");
  #ifndef NO_AD_INITIALIZE
  Kobs_tot_catch.initialize();
  #endif
  Nstage.allocate(1,nages,"Nstage");
  #ifndef NO_AD_INITIALIZE
    Nstage.initialize();
  #endif
  sel_fishr.allocate(1,nages,"sel_fishr");
  #ifndef NO_AD_INITIALIZE
    sel_fishr.initialize();
  #endif
  sel_fishp.allocate(1,nages,"sel_fishp");
  #ifndef NO_AD_INITIALIZE
    sel_fishp.initialize();
  #endif
  Rpred.allocate(styr,endyr,"Rpred");
  #ifndef NO_AD_INITIALIZE
    Rpred.initialize();
  #endif
  pred_survnum.allocate(styr,endyr,"pred_survnum");
  #ifndef NO_AD_INITIALIZE
    pred_survnum.initialize();
  #endif
  pred_survnump.allocate(styr,endyr,"pred_survnump");
  #ifndef NO_AD_INITIALIZE
    pred_survnump.initialize();
  #endif
  biomass_future.allocate(styr_fut,endyr_fut,"biomass_future");
  #ifndef NO_AD_INITIALIZE
    biomass_future.initialize();
  #endif
  rbmsy.allocate(styr,endyr,"rbmsy");
  #ifndef NO_AD_INITIALIZE
    rbmsy.initialize();
  #endif
  sd_age.allocate(1,nages,"sd_age");
  #ifndef NO_AD_INITIALIZE
    sd_age.initialize();
  #endif
  var_age.allocate(1,nages,"var_age");
  #ifndef NO_AD_INITIALIZE
    var_age.initialize();
  #endif
  bioadul_future.allocate(styr_fut,endyr_fut,"bioadul_future");
  #ifndef NO_AD_INITIALIZE
    bioadul_future.initialize();
  #endif
  ssbiom_future.allocate(styr_fut,endyr_fut,"ssbiom_future");
  #ifndef NO_AD_INITIALIZE
    ssbiom_future.initialize();
  #endif
  tasa_E.allocate(styr,endyr,"tasa_E");
  #ifndef NO_AD_INITIALIZE
    tasa_E.initialize();
  #endif
  BR.allocate(styr,endyr,"BR");
  #ifndef NO_AD_INITIALIZE
    BR.initialize();
  #endif
  BR2.allocate(styr,endyr,"BR2");
  #ifndef NO_AD_INITIALIZE
    BR2.initialize();
  #endif
  mu_edad.allocate(1,nages,"mu_edad");
  #ifndef NO_AD_INITIALIZE
    mu_edad.initialize();
  #endif
  explbiom.allocate(styr,endyr,"explbiom");
  #ifndef NO_AD_INITIALIZE
    explbiom.initialize();
  #endif
  bioadul.allocate(styr,endyr,"bioadul");
  #ifndef NO_AD_INITIALIZE
    bioadul.initialize();
  #endif
  npr.allocate(1,nages,"npr");
  #ifndef NO_AD_INITIALIZE
    npr.initialize();
  #endif
  expl_biom.allocate(styr_fut,endyr_fut,"expl_biom");
  #ifndef NO_AD_INITIALIZE
    expl_biom.initialize();
  #endif
  ssbiom2P.allocate(styr,endyr,"ssbiom2P");
  #ifndef NO_AD_INITIALIZE
    ssbiom2P.initialize();
  #endif
  Neq.allocate(1,nages,"Neq");
  #ifndef NO_AD_INITIALIZE
    Neq.initialize();
  #endif
  avg_F_future.allocate(1,5,"avg_F_future");
  #ifndef NO_AD_INITIALIZE
    avg_F_future.initialize();
  #endif
  surv_like_residuals.allocate(1,nobs_surv,"surv_like_residuals");
  #ifndef NO_AD_INITIALIZE
    surv_like_residuals.initialize();
  #endif
  ssqcatch_residuals.allocate(styr,endyr,"ssqcatch_residuals");
  #ifndef NO_AD_INITIALIZE
    ssqcatch_residuals.initialize();
  #endif
  surv_like_residualspel.allocate(1,nobs_survpel,"surv_like_residualspel");
  #ifndef NO_AD_INITIALIZE
    surv_like_residualspel.initialize();
  #endif
  cpue_like_residuals.allocate(1,nobs_cpue,"cpue_like_residuals");
  #ifndef NO_AD_INITIALIZE
    cpue_like_residuals.initialize();
  #endif
  recruits.allocate(styr,endyr,"recruits");
  #ifndef NO_AD_INITIALIZE
    recruits.initialize();
  #endif
  age_sel.allocate(styr,endyr,1,nages,"age_sel");
  #ifndef NO_AD_INITIALIZE
    age_sel.initialize();
  #endif
  log_sel_f1.allocate(styr,endyr,1,nages,"log_sel_f1");
  #ifndef NO_AD_INITIALIZE
    log_sel_f1.initialize();
  #endif
  sel_f1.allocate(styr,endyr,1,nages,"sel_f1");
  #ifndef NO_AD_INITIALIZE
    sel_f1.initialize();
  #endif
  trans.allocate(1,nages,1,nlenbins,"trans");
  #ifndef NO_AD_INITIALIZE
    trans.initialize();
  #endif
  sel_fish.allocate(styr,endyr,1,nages,"sel_fish");
  #ifndef NO_AD_INITIALIZE
    sel_fish.initialize();
  #endif
  age_sel2.allocate(styr,endyr,1,nages,"age_sel2");
  #ifndef NO_AD_INITIALIZE
    age_sel2.initialize();
  #endif
  size_sel.allocate(styr,endyr,1,nlenbins,"size_sel");
  #ifndef NO_AD_INITIALIZE
    size_sel.initialize();
  #endif
  size_selr.allocate(styr,endyr,1,nlenbins,"size_selr");
  #ifndef NO_AD_INITIALIZE
    size_selr.initialize();
  #endif
  size_selp.allocate(styr,endyr,1,nlenbins,"size_selp");
  #ifndef NO_AD_INITIALIZE
    size_selp.initialize();
  #endif
  age_selr.allocate(styr,endyr,1,nages,"age_selr");
  #ifndef NO_AD_INITIALIZE
    age_selr.initialize();
  #endif
  age_selp.allocate(styr,endyr,1,nages,"age_selp");
  #ifndef NO_AD_INITIALIZE
    age_selp.initialize();
  #endif
  pred_p_age.allocate(styr,endyr,1,nages,"pred_p_age");
  #ifndef NO_AD_INITIALIZE
    pred_p_age.initialize();
  #endif
  pred_p_agereclas.allocate(1,nobs_surv,1,nages,"pred_p_agereclas");
  #ifndef NO_AD_INITIALIZE
    pred_p_agereclas.initialize();
  #endif
  pred_p_agepelaces.allocate(1,nobs_survpel,1,nages,"pred_p_agepelaces");
  #ifndef NO_AD_INITIALIZE
    pred_p_agepelaces.initialize();
  #endif
  pred_p_agep.allocate(styr,endyr,1,nages,"pred_p_agep");
  #ifndef NO_AD_INITIALIZE
    pred_p_agep.initialize();
  #endif
  pred_p_len.allocate(1,nobs_fishlen,1,nlenbins,"pred_p_len");
  #ifndef NO_AD_INITIALIZE
    pred_p_len.initialize();
  #endif
  pred_p_lenreclas.allocate(1,nobs_surv,1,nlenbins,"pred_p_lenreclas");
  #ifndef NO_AD_INITIALIZE
    pred_p_lenreclas.initialize();
  #endif
  pred_p_lenpelaces.allocate(1,nobs_survpel,1,nlenbins,"pred_p_lenpelaces");
  #ifndef NO_AD_INITIALIZE
    pred_p_lenpelaces.initialize();
  #endif
  natage.allocate(styr,endyr,1,nages,"natage");
  #ifndef NO_AD_INITIALIZE
    natage.initialize();
  #endif
  natage2.allocate(styr,endyr,1,nages,"natage2");
  #ifndef NO_AD_INITIALIZE
    natage2.initialize();
  #endif
  natsize.allocate(styr,endyr,1,nlenbins,"natsize");
  #ifndef NO_AD_INITIALIZE
    natsize.initialize();
  #endif
  catage.allocate(styr,endyr,1,nages,"catage");
  #ifndef NO_AD_INITIALIZE
    catage.initialize();
  #endif
  Z.allocate(styr,endyr,1,nages,"Z");
  #ifndef NO_AD_INITIALIZE
    Z.initialize();
  #endif
  F.allocate(styr,endyr,1,nages,"F");
  #ifndef NO_AD_INITIALIZE
    F.initialize();
  #endif
  S.allocate(styr,endyr,1,nages,"S");
  #ifndef NO_AD_INITIALIZE
    S.initialize();
  #endif
  S2.allocate(styr,endyr,1,nages,"S2");
  #ifndef NO_AD_INITIALIZE
    S2.initialize();
  #endif
  F_future.allocate(styr_fut,endyr_fut,1,nages,"F_future");
  #ifndef NO_AD_INITIALIZE
    F_future.initialize();
  #endif
  Z_future.allocate(styr_fut,endyr_fut,1,nages,"Z_future");
  #ifndef NO_AD_INITIALIZE
    Z_future.initialize();
  #endif
  S_future.allocate(styr_fut,endyr_fut,1,nages,"S_future");
  #ifndef NO_AD_INITIALIZE
    S_future.initialize();
  #endif
  catage_future.allocate(styr_fut,endyr_fut,1,nages,"catage_future");
  #ifndef NO_AD_INITIALIZE
    catage_future.initialize();
  #endif
  Nspr.allocate(1,4,1,nages,"Nspr");
  #ifndef NO_AD_INITIALIZE
    Nspr.initialize();
  #endif
  nage_future.allocate(styr_fut,endyr_fut,1,nages,"nage_future");
  #ifndef NO_AD_INITIALIZE
    nage_future.initialize();
  #endif
  pred_p_residual.allocate(1,nobs_fishlen,1,nlenbins,"pred_p_residual");
  #ifndef NO_AD_INITIALIZE
    pred_p_residual.initialize();
  #endif
  pred_p_residualspelaces.allocate(1,nobs_survpel,1,nlenbins,"pred_p_residualspelaces");
  #ifndef NO_AD_INITIALIZE
    pred_p_residualspelaces.initialize();
  #endif
  pred_p_residualsreclas.allocate(1,nobs_surv,1,nlenbins,"pred_p_residualsreclas");
  #ifndef NO_AD_INITIALIZE
    pred_p_residualsreclas.initialize();
  #endif
  catch_future.allocate(1,4,styr_fut,endyr_fut,"catch_future");
  #ifndef NO_AD_INITIALIZE
    catch_future.initialize();
  #endif
  future_biomass.allocate(1,5,styr_fut,endyr_fut,"future_biomass");
  #ifndef NO_AD_INITIALIZE
    future_biomass.initialize();
  #endif
  future_bioadul.allocate(1,5,styr_fut,endyr_fut,"future_bioadul");
  #ifndef NO_AD_INITIALIZE
    future_bioadul.initialize();
  #endif
  future_ssbiom.allocate(1,5,styr_fut,endyr_fut,"future_ssbiom");
  #ifndef NO_AD_INITIALIZE
    future_ssbiom.initialize();
  #endif
  bio1_ratio.allocate(1,5,styr_fut,endyr_fut,"bio1_ratio");
  #ifndef NO_AD_INITIALIZE
    bio1_ratio.initialize();
  #endif
  bio2_ratio.allocate(1,5,styr_fut,endyr_fut,"bio2_ratio");
  #ifndef NO_AD_INITIALIZE
    bio2_ratio.initialize();
  #endif
  endbtot.allocate("endbtot");
  endssb.allocate("endssb");
  endbadul.allocate("endbadul");
  lastF.allocate("lastF");
  Fmort.allocate(styr,endyr,"Fmort");
  RPR.allocate(styr,endyr,"RPR");
  totbiom.allocate(styr,endyr,"totbiom");
  ssbiom.allocate(styr,endyr,"ssbiom");
  pred_surv.allocate(styr,endyr,"pred_surv");
  pred_cpue.allocate(styr,endyr,"pred_cpue");
  pred_survpel.allocate(styr,endyr,"pred_survpel");
  pred_catch.allocate(styr,endyr,"pred_catch");
  f.allocate("f");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
    for (int i=1; i<= nobs_fishlen; i++)
   {
      obs_p_len(i)=obs_p_len(i);
      for (int j=1;j <= nlenbins; j++)
      {
        if (obs_p_len(i,j)>0.0)
        {
          offset-=nlen_fish*obs_p_len(i,j)*log(obs_p_len(i,j));
        }
      }
    }
    for (int i=1; i<= nobs_surv; i++)
   {
      obs_p_lenreclas(i)=obs_p_lenreclas(i);
      for (int j=1;j <= nlenbins; j++)
      {
        if (obs_p_lenreclas(i,j)>0.0)
        {
          offsetr-=nlen_fish*obs_p_lenreclas(i,j)*log(obs_p_lenreclas(i,j));
        }
      }
    }
    for (int i=1; i<= nobs_survpel; i++)
   {
      obs_p_lenpelaces(i)=obs_p_lenpelaces(i);
      for (int j=1;j <= nlenbins; j++)
      {
        if (obs_p_lenpelaces(i,j)>0.0)
        {
          offsetr-=nlen_fish*obs_p_lenpelaces(i,j)*log(obs_p_lenpelaces(i,j));
        }
      }
    }
  //k1 = kdat; cg eliminado
  //t0 = t0dat;
  //C  = Cdat;  //??? se elimina cg
  //Ts = Tsdat; //??? idem
  get_agematrix();
}

void model_parameters::userfunction(void)
{
  f =0.0;
  get_selectividad();
  get_mortalidad();
  get_abundancia();
  get_captura();
  get_stock_recluta();
  if (active(F40))
  {
    spr();
  }
  if (last_phase())
  {
    proyecciones();
  }
  evaluate_the_objective_function();
  if (mceval_phase())
    MCWrite();
}

void model_parameters::get_agematrix(void)
{
  linf    = crecimiento(1);
  k1      = crecimiento(2);
  if(opt_VB<0)
  {
    Lo      = crecimiento(3);
    cv_edad = crecimiento(4);
  }
  else
  {
    Lo      = mfexp(log_Lo);
    cv_edad = mfexp(log_cv_edad);
  }
  int i, j;
  mu_edad(1)=Lo;
  for (i=2;i<=nages;i++)
  {
    mu_edad(i) = linf*(1-mfexp(-k1))+exp(-k1)*mu_edad(i-1);  //CG cambio k1 por k
  }
  for (int i=1;i<=nages;i++)
  {
    sd_age(i)  = cv_age(i)*mu_edad(i);
    var_age(i) = sd_age(i)*sd_age(i);
    for (int j=1;j<=nlenbins;j++)
    {
      diff       = len(j)-mu_edad(i);
      trans(i,j) = 2/sd_age(i)*exp(-diff*diff/(2*var_age(i)));
    }
    trans(i)=trans(i)/sum(trans(i)); 
  }
}

void model_parameters::get_selectividad(void)
{
  avgsel_fish1=log(mean(exp(log_selcoffs_f1)));
  for (int j=1;j<=nselagef1;j++)
  {
    log_sel_f1(styr,j)=log_selcoffs_f1(j);
  }
  for (int j=nselagef1+1;j<=nages;j++)
  {
    log_sel_f1(styr,j)=log_sel_f1(styr,j-1);
  }
  log_sel_f1(styr)-=log(mean(exp(log_sel_f1(styr))));
  int ii;
  if(active(sel_devs_f1))
  {
   ii=1;
   for (int i=styr;i<endyr;i++)
    {
     if (!(i%group_num_f1))
     {
      for (int j=1;j<=nselagef1;j++)
       {
        log_sel_f1(i+1,j)=log_sel_f1(i,j)+sel_devs_f1(ii,j);
       }
      for (int j=nselagef1+1;j<=nages;j++)
       {
        log_sel_f1(i+1,j)=log_sel_f1(i+1,j-1);
       }
      ii++;
      log_sel_f1(i+1)-=log(mean(mfexp(log_sel_f1(i+1))));
     }
  else
  {
    for (int j=1;j<=nselagef1;j++)
    {
      log_sel_f1(i+1,j)=log_sel_f1(i,j);
    }
      for (int j=nselagef1+1;j<=nages;j++)
      {
        log_sel_f1(i+1,j)=log_sel_f1(i+1,j-1);
      }
      log_sel_f1(i+1)-=log(mean(mfexp(log_sel_f1(i+1))));
    }
  }
  }
  else
  {
   for (int i=styr;i<endyr;i++)
   {
      for (int j=1;j<=nselagef1;j++)
      {
        log_sel_f1(i+1,j)=log_sel_f1(i,j);
      }
      for (int j=nselagef1+1;j<=nages;j++)
      {
        log_sel_f1(i+1,j)=log_sel_f1(i+1,j-1);
      }
    }
  }
  sel_f1   =exp(log_sel_f1);
  age_sel  =sel_f1;
  size_sel =age_sel*trans;  
  // a_50 = mfexp(log_a50);
  // a_95 = mfexp(log_a95);
  for (int j=1;j<=nages;j++)
  {
    sel_fishr(j)=1./(1.+mfexp(-log(19)*(edad(j)-a50)/(a95)));
  }
  for (int i=styr;i<=endyr;i++)
  {
    for(int j=1;j<=nages;j++)
    {
      age_selr(i,j) = sel_fishr(j);
    }
  }  
  size_selr=age_selr*trans;//conversion a tallas
  // a_50p = mfexp(log_a50p);
  // a_95p = mfexp(log_a95p);
  for (int j=1;j<=nages;j++)
  {
    sel_fishp(j) = 1./(1.+mfexp(-log(19)*(edad(j)-a50p)/(a95p)));
  }
  for (int i=styr;i<=endyr;i++)
  {
    for(int j=1;j<=nages;j++)
     {
        age_selp(i,j)=sel_fishp(j);
       }
    }  
  size_selp=age_selp*trans;//conversion a tallas  
}

void model_parameters::get_mortalidad(void)
{
  Fmort=mfexp(fmort_dev);
  for (int i=styr;i<=endyr;i++)
  {
    for (int j=1;j<=nages;j++)
    {
      F(i,j)=Fmort(i)*age_sel(i,j);
    }
  }
  Z    = F+M;
  S    = mfexp(-Z);
  surv = mfexp(-M);
}

void model_parameters::get_abundancia(void)
{
  int itmp;
  int i;
  int j;
  Neq(1)=1;
  for (j=2;j<=nages;j++)
  {
    Neq(j)     = Neq(j-1)*mfexp(-1*M);} 
    Neq(nages) = Neq(nages)/(1-exp(-1*M)); 
    BPRo       = sum(elem_prod(Neq,wti));  
    log_Ro     = log_Bo-log(BPRo);          // OjO, this parameter not used elsewhere...
    Nstage     = Neq*mfexp(mean_log_rec)+0.5*square(sigr);
    for (int j=2;j<=nages;j++)
    {
      natage(styr,j)= mfexp(log_Nini+log_dev_ini(j))+0.5*square(sigr);
    }
    for (int i=styr;i<=106;i++) 
    {
      natage(i,1)=mfexp(mean_log_rec+rec_dev(i))+0.5*square(sigr);
    }
    for (int i=107;i<=endyr;i++)
    {
      natage(i,1)=mfexp(mean_log_rec1+rec_dev(i))+0.5*square(sigr);
    }
    for (int i=styr;i < endyr;i++)
    {
      natage(i+1)(2,nages)=++elem_prod(natage(i)(1,nages-1),S(i)(1,nages-1));
  	  natage(i+1,nages)+=natage(i,nages)*S(i,nages)+natage(i,nages)*S(i,nages);
  	}
  q_fish    = exp(log_q_cpue);
  q_surv    = exp(log_q_surv);
  q_survpel = exp(log_q_survpel);
  for (int i=styr;i<=endyr;i++)
  {
   pred_cpue(i)     =0.;
   pred_surv(i)     =0.;
   pred_survnum(i)  =0.;
   pred_survpel(i)  =0.;
   pred_survnump(i) =0.;
   explbiom(i)      =0.;
   totbiom(i)       =0.;
   ssbiom(i)        =0.;
   bioadul(i)       =0.;
   BR(i)            =0.;
   RPR(i)           =0.;
   for (int j=1;j<=nages;j++)
   {
	  pred_cpue(i)+=q_fish*age_sel(i,j)*natage(i,j)*wta(i,j);    
	  pred_surv(i)+=q_surv*natage(i,j)*wta(i,j)*age_selr(i,j)*exp(-reclasMo_Frac*Z(i,j)); 
      pred_survnum(i)+=q_surv*natage(i,j)*age_selr(i,j)*exp(-reclasMo_Frac*Z(i,j));
	  pred_survpel(i)+=q_survpel*natage(i,j)*wta(i,j)*age_selp(i,j)*exp(-pelacesMo_Frac*Z(i,j));
      pred_survnump(i)+=q_survpel*natage(i,j)*age_selp(i,j)*exp(-pelacesMo_Frac*Z(i,j));	  
	  explbiom(i)+=natage(i,j)*age_sel(i,j)*wta(i,j)*(1.-exp(-Z(i,j)))/Z(i,j);
      totbiom(i)+=natage(i,j)*wta(i,j);
      ssbiom(i)+=natage(i,j)*wta(i,j)*maturity(j)*mfexp(-SpawnMo_Frac*Z(i,j));
      bioadul(i)+=natage(i,j)*wta(i,j)*maturity(j);
	  BR(i)=natage(i,1);
	  RPR(i)=ssbiom(i)/So;
    }
  }
  natsize  =natage*trans;
  endbtot  =totbiom(endyr);
  endbadul =bioadul(endyr);
  endssb   =ssbiom(endyr);
  lastF    =Fmort(endyr);
  Rlast    =natage(endyr,1);
  Rmedio   =mean(BR);
  Fmsylast =lastF/F60;
  for (int i=styr;i<=endyr;i++)
  {
   recruits(i)=natage(i,1);
   tasa_E(i)=catch_bio(i)/totbiom(i);
  }
}

void model_parameters::get_captura(void)
{
  for (int i=styr;i<=endyr; i++)
  {
     pred_catch(i)=0.;
     for (int j=1;j<=nages; j++)
     {
       catage(i,j) = natage(i,j)*F(i,j)*(1.-S(i,j))/Z(i,j);
       pred_catch(i)+=catage(i,j)*wta(i,j);
     }
     pred_p_age(i)=catage(i)/sum(catage(i));
   }
   for (int i=1;i<=nobs_fishlen;i++)
    {
     pred_p_len(i)=pred_p_age(yr_fishlen(i))*trans;
    }
    pred_p_residual=obs_p_len-pred_p_len;
    for (int i=styr; i<= endyr; i++)
    {
      pred_p_agep(i)=natage(i)/sum(natage(i));
     }
  for (int i=1;i<=nobs_surv;i++)
  {
    int ii;
		ii = yr_fishlenreclas(i);
    for (int j=1;j<=nages;j++)
    {
      pred_p_agereclas(i,j)=q_surv*natage(ii,j)*age_selr(ii,j)*exp(-reclasMo_Frac*Z(ii,j))/pred_survnum(ii); 
    }                                    
  }
  for (int i=1;i<=nobs_surv;i++)  
  {
    pred_p_lenreclas(i)=pred_p_agereclas(i)*trans;
  }
  pred_p_residualsreclas=obs_p_lenreclas-pred_p_lenreclas;
	for (int i=1;i<=nobs_survpel;i++)
  {
    int ii;
		ii=yr_fishlenpelaces(i);
    for (int j=1;j<=nages;j++)
    {
      pred_p_agepelaces(i,j)=q_survpel*natage(ii,j)*age_selp(ii,j)*exp(-pelacesMo_Frac*Z(ii,j))/pred_survnump(ii); 
    }                                    
  }
  for (int i=1;i<=nobs_survpel;i++)  
  {
    pred_p_lenpelaces(i) = pred_p_agepelaces(i)*trans;
  }
  pred_p_residualspelaces = obs_p_lenpelaces-pred_p_lenpelaces;	
}

void model_parameters::spr(void)
{
  SB0=0.;
  SBF60=0.;
  SBF40=0.;
  SBF20=0.;
  for (int i=1;i<=4;i++)
    Nspr(i,1)=1.;
  for (int j=2;j<nages;j++)
  {
    Nspr(1,j)=Nspr(1,j-1)*exp(-1.*M);
    Nspr(2,j)=Nspr(2,j-1)*exp(-1.*(M+F60*age_sel(endyr,j-1)));
    Nspr(3,j)=Nspr(3,j-1)*exp(-1.*(M+F40*age_sel(endyr,j-1)));
    Nspr(4,j)=Nspr(4,j-1)*exp(-1.*(M+F20*age_sel(endyr,j-1)));
  }   
  Nspr(1,nages)=Nspr(1,nages-1)*exp(-1.*M)/(1.-exp(-1.*M));
  Nspr(2,nages)=Nspr(2,nages-1)*exp(-1.* (M+F60*age_sel(endyr,nages-1)))/(1.-exp(-1.*(M+F60*age_sel(endyr,nages))));
  Nspr(3,nages)=Nspr(2,nages-1)*exp(-1.* (M+F40*age_sel(endyr,nages-1)))/(1.-exp(-1.*(M+F40*age_sel(endyr,nages))));
  Nspr(4,nages)=Nspr(4,nages-1)*exp(-1.* (M+F20*age_sel(endyr,nages-1)))/(1.-exp(-1.*(M+F20*age_sel(endyr,nages))));
  for (int j=1;j<=nages;j++)
  {
    SB0    += Nspr(1,j)*maturity(j)*wt(j)*exp(-SpawnMo_Frac*M);
    SBF60  += Nspr(2,j)*maturity(j)*wt(j)*exp(-SpawnMo_Frac*(M+F60*age_sel(endyr,j)));
    SBF40  += Nspr(3,j)*maturity(j)*wt(j)*exp(-SpawnMo_Frac*(M+F40*age_sel(endyr,j)));
    SBF20  += Nspr(4,j)*maturity(j)*wt(j)*exp(-SpawnMo_Frac*(M+F20*age_sel(endyr,j)));
   }
  sprpen    = 300.*square(SBF60/SB0-0.60);
  sprpen   += 300.*square(SBF40/SB0-0.40);
  sprpen   += 300.*square(SBF20/SB0-0.20);
}

void model_parameters::proyecciones(void)
{
   nage_future(styr_fut)(2,nages)=++elem_prod(natage(endyr)(1,nages-1),S(endyr)(1,nages-1));
   nage_future(styr_fut,nages)+=natage(endyr,nages)*S(endyr,nages);
   nage_future(styr_fut,1)=(Rmedio+rec_dev_future(styr_fut)+0.5*square(sigr));//reclutamiento medio 1991-2016
   future_bioadul=0.;
   future_ssbiom=0.;
   future_biomass=0.;
   catch_future=0.;
   for (int k=1;k<=5;k++)
   {
	   switch(k)
	   {
		   case 1:
		   ftmp=F60;
		   break;
		   case 2:
		   ftmp=F40;
		   break;
		   case 3:
		   ftmp=F20;
		   break;
		   case 4:
		   ftmp=lastF;
		   break;
		   case 5:
		   ftmp=0.0;
		   break;
	   }
     for (int i=styr_fut;i<=endyr_fut;i++)
	 {
		 for (int j=1;j<=nages;j++)
		 {
			 F_future(i,j)=age_sel(endyr,j)*ftmp;
			 Z_future(i,j)=F_future(i,j)+M;
			 S_future(i,j)=exp(-1.*Z_future(i,j));
		 }
	}
     ssbiom_future(styr_fut)=0.;
     for (int j=1;j<=nages;j++)
	 {
		 ssbiom_future(styr_fut)+=nage_future(styr_fut,j)*wt(j)*maturity(j)*exp(-SpawnMo_Frac*Z_future(styr_fut,j));
	 }
     nage_future(styr_fut+1,1)=(Rmedio+rec_dev_future(styr_fut+1)+0.5*square(sigr));
     for (int j=1;j<nages;j++)
	 {
		nage_future(styr_fut+1,j+1)=nage_future(styr_fut,j)*S_future(styr_fut,j);
	 }
	 nage_future(styr_fut+1,nages)+=nage_future(styr_fut,nages)*S_future(styr_fut,nages);
      ssbiom_future(styr_fut+1)=0;
      for (int j=1;j<=nages;j++)
       {
        ssbiom_future(styr_fut+1)+=nage_future(styr_fut+1,j)*wt(j)*maturity(j)*exp(-SpawnMo_Frac*Z_future(styr_fut+1,j));
       }  
     for (int i=styr_fut+2;i<=endyr_fut;i++)
      {
       ssbiom_future(i)=0.;
       nage_future(i,1)=(Rmedio+rec_dev_future(i)+0.5*square(sigr));
       for (int j=1;j<nages;j++)
       {  
        nage_future(i,j+1)=nage_future(i-1,j)*S_future(i-1,j);
        ssbiom_future(i)+=nage_future(i,j)*wt(j)*maturity(j)*exp(-SpawnMo_Frac*Z_future(i,j));
       }
       nage_future(i,nages)+=nage_future(i,nages)*S_future(i,nages);
       ssbiom_future(i)+=nage_future(i,nages)*wt(nages)*maturity(nages)*exp(-SpawnMo_Frac*Z_future(i,nages));
    }
	for (int i=styr_fut;i<=endyr_fut;i++)
      {
       biomass_future(i)=0.;
       bioadul_future(i)=0.;
       for (int j=1;j<=nages;j++)
        {
         biomass_future(i)+=nage_future(i,j)*wt(j);
         bioadul_future(i)+=nage_future(i,j)*wt(j)*maturity(j);
        }
      }
     {
	 for (int i=styr_fut;i<=endyr_fut;i++)
      {
       for (int j=1;j<=nages;j++)
        {
        catage_future(i,j)=nage_future(i,j)*F_future(i,j)*(1.-S_future(i,j))/Z_future(i,j);
        }
        if (k!=5) catch_future(k,i)+=catage_future(i)*wt;
	    future_biomass(k,i)=biomass_future(i);
        future_bioadul(k,i)=bioadul_future(i);
        future_ssbiom(k,i)=ssbiom_future(i);
        bio1_ratio(k,i)=biomass_future(i)/endbtot;
        bio2_ratio(k,i)=bioadul_future(i)/endbadul;
	    }
      }
    }
}

void model_parameters::Future_projections_fixed_catch(void)
{
  nage_future(styr_fut)(2,nages)=++elem_prod(natage(endyr)(1,nages-1),S(endyr)(1,nages-1));
  nage_future(styr_fut,nages)+=natage(endyr,nages)*S(endyr,nages);
  future_biomass=0.;
  catch_future=0.;
  future_bioadul=0.;
  future_ssbiom=0.;
  for (int l=1;l<=5;l++)
  {
    if (l<5) 
      {
       catch_future(l)=MLE_catch(l);
      }
    for (int i=styr_fut;i<=endyr_fut;i++)
    {
      nage_future(i,1)=mfexp(rec_dev_future(i)+mean_log_rec);
        expl_biom(i)=nage_future(i)*elem_prod(age_sel(endyr),wt);
        if (l==5)
         {
          F_future(i)=0.;
         }
        else
         {
         dvariable ffpen=0.0;
         dvariable SK=posfun((expl_biom(i)-catch_future(l,i))/expl_biom(i),0.05,ffpen);
         Kobs_tot_catch=expl_biom(i)-SK*expl_biom(i); 
          do_Newton_Raphson_for_mortality(i);
         }
         Z_future(i)=F_future(i)+M;
         S_future(i)=exp(-1.*Z_future(i));
         avg_F_future(l)=mean(F_future);
         bioadul_future(i)=elem_prod(nage_future(i),maturity)*wt;
         biomass_future(i)=0;
         ssbiom_future(i)=0;
         for (int j=1;j<=nages;j++)
           {
            ssbiom_future(i)+=nage_future(i,j)*maturity(j)*wt(j)*exp(SpawnMo_Frac*Z_future(i,j));
            biomass_future(i)+=nage_future(i,j)*wt(j);
           }
         if (i<endyr_fut)
          {
           nage_future(i+1)(2,nages)=++elem_prod(nage_future(i)(1,nages-1),S_future(i)(1,nages-1));
           nage_future(i+1,nages)+=nage_future(i,nages)*S_future(i,nages);
          }
    }
	 for (int i=styr_fut; i<=endyr_fut; i++)
    {
      if (l!=5) // Don't compute catch for F=0
      {
        catage_future(i)=elem_prod(elem_div(F_future(i),Z_future(i)),elem_prod(1.-S_future(i),nage_future(i)));
        catch_future(l,i)=catage_future(i)*wt;
		}
      future_biomass(l,i) = biomass_future(i);
      future_bioadul(l,i) = bioadul_future(i);
      future_ssbiom(l,i) = ssbiom_future(i);
      bio1_ratio(l,i)=biomass_future(i)/endbtot;
      bio2_ratio(l,i)=bioadul_future(i)/endbadul;
    }
  }
}

void model_parameters::do_Newton_Raphson_for_mortality(int i)
{
  dvariable Fold = Kobs_tot_catch/expl_biom(i);
  dvariable Fnew ;
  for (int ii=1;ii<=5;ii++)
  {
      dvariable ZZ = Fold + M;
      dvariable XX = exp(-1.*ZZ);
      dvariable AA = Fold * (1. - XX);
      dvariable BB = ZZ;
      dvariable CC = 1. + (Fold - 1) * XX;
      dvariable dd = 1.;
      dvariable FX = AA / BB - Kobs_tot_catch/expl_biom(i);
      dvariable FPX = (BB * CC - AA * dd) / (BB * BB);
      Fnew = Fold - FX / FPX;
      Fold = Fnew;
  }
  F_future(i)=Fnew*age_sel(endyr);
}

void model_parameters::get_stock_recluta(void)
{
  So=sum(elem_prod(elem_prod(Nstage*exp(-SpawnMo_Frac*M),maturity),wti));
  alfa=(So/mfexp(mean_log_rec))*(1-h)/(4*h);
  beta1=(5*h-1)/(4*h*mfexp(mean_log_rec));
  beta2=(5*h-1)/(4*h*mfexp(mean_log_rec1)); //1
  bmsy=0.55*So;
  rbmsylast=endssb/bmsy;
  Rpred(styr)= mfexp(mean_log_rec);
  for(int i=styr+1;i<=106;i++)
  {
	Rpred(i)=ssbiom(i-1)/(alfa+beta1*ssbiom(i-1));
    }
  for(int i=107;i<=endyr;i++)
  {
	Rpred(i)=ssbiom(i-1)/(alfa+beta2*ssbiom(i-1));
    }
  for(int i=styr;i<=endyr;i++)
  {
  rbmsy(i)=ssbiom(i)/bmsy;
    }
}

void model_parameters::evaluate_the_objective_function(void)
{
   dvariable temp;
   int ii;
   rec_like=norm2(rec_dev)/(2*square(sigr))+size_count(rec_dev)*log(sigr);
   if (active(rec_dev_future))
   {
     if (active(rec_dev_future))
      {
       sigmar_fut=sigr;
       rec_like+=norm2(rec_dev_future)/(2*square(sigmar_fut))+size_count(rec_dev_future)*log(sigmar_fut);
      }
    }
   age_like=0.;
    for (int i=1; i<=nobs_fishlen; i++)
    {
      for (int j=1; j<=nlenbins; j++)
      {
        age_like-=nlen_fish*obs_p_len(i,j)*log(pred_p_len(i,j)+1.e-13);
      }
    }
   //age_like-=offset;
   age_liker=0.;
    for (int i=1; i<=nobs_surv; i++)
    {
      for (int j=1; j<=nlenbins; j++)
      {
        age_liker-=nlen_fishr*obs_p_lenreclas(i,j)*log(pred_p_lenreclas(i,j)+1.e-13);
		//surv_like_residuals=(obs_p_lenreclas-pred_p_lenreclas)/std_dev(obs_p_lenreclas);
      }
    }
    //age_liker-=offsetr;
   age_likep=0.;
    for (int i=1; i<=nobs_survpel; i++)
    {
      for (int j=1; j<=nlenbins; j++)
      {
        age_likep-=nlen_fishp*obs_p_lenpelaces(i,j)*log(pred_p_lenpelaces(i,j)+1.e-13);
      }
    }
    //age_likep-=offsetp;
   cvage_like=0.;
   cvage_like=10*norm2(cv_edad-obs_CV);
   temp = 0;                                       
   for (int i=1;i<=nobs_cpue;i++)
   {
   ii=yr_cpue(i);
   temp += square(log(pred_cpue(ii)/obs_cpue(i)));
   }
   cpue_like = nobs_cpue*log(CV_cpue)+temp/(2.0*square(CV_cpue)); //log-likelihood
   for (int i=1;i<=nobs_cpue;i++)
  {
   cpue_like_residuals(i)=0.0;  
   int xx;
   xx=yr_cpue(i);
   cpue_like_residuals(i)=obs_cpue(i)-pred_cpue(xx);
   } 
   temp = 0;
   for (int i=styr;i<=endyr;i++)
   {
   temp += square(log(catch_bio(i)/pred_catch(i)));
   }
   catch_like = size_count(catch_bio)*log(CV_catch)+temp/(2.0*square(CV_catch));
   ssqcatch_residuals=(catch_bio-pred_catch)/std_dev(catch_bio);
   temp = 0;
   for (int i=1;i<=nobs_surv;i++)
    {
   ii=yr_surv(i);
   temp += square(log(pred_surv(ii)/obs_surv(i)));
   surv_like = nobs_surv*log(CV_surv)+temp/(2.0*square(CV_surv));
   surv_like_residuals=(obs_surv-pred_surv(ii))/std_dev(obs_surv);
    }
	temp = 0;
  for (int i=1;i<=nobs_survpel;i++)
    {
    ii=yr_survpel(i);
    temp += square(log(pred_survpel(ii)/obs_survpel(i)));
    }
  surv_likepel = nobs_survpel*log(CV_survpel)+temp/(2.0*square(CV_survpel)); //
  surv_like_residualspel=(obs_survpel-pred_survpel(ii))/std_dev(obs_survpel);
  sel_like.initialize();
  sel_dev_like.initialize();
  for (int i=styr;i<=endyr;i++)
  {
  for (int j=1;j<nages;j++)
    {
   if (log_sel_f1(i,j)>log_sel_f1(i,j+1))
      {
       sel_like+=lambda(1)*square(log_sel_f1(i,j)-log_sel_f1(i,j+1));
       }
     }
   }
   if (active(sel_devs_f1))
    {
      sel_dev_like+=lambda(2)/group_num_f1*norm2(sel_devs_f1);
      sel_dev_like+=lambda(3)/dim_sel_f1*norm2(first_difference(first_difference(log_sel_f1(styr))));
      for (int i=styr;i<endyr;i++)
       {
        if (!(i%group_num_f1))
         {
          sel_dev_like+=lambda(3)/dim_sel_f1*norm2(first_difference(first_difference(log_sel_f1(i+1))));
         }
       }
    }
    else
    {
      sel_dev_like+=lambda(3)*norm2(first_difference(first_difference(log_sel_f1(styr))));
    }
  //verosimilitudes total  
  f += rec_like;
  f += sel_like;
  f += sel_dev_like;
  f += age_like;
  f += age_liker;
  f += age_likep;
  f += cpue_like;
  f += catch_like;
  f += surv_like;
  f += surv_likepel;
  f += cvage_like;
  if (current_phase()<3)
    fpen= 10.*norm2(mfexp(fmort_dev+log_avg_fmort)-.2);
  else
    fpen= .3*norm2(mfexp(fmort_dev+log_avg_fmort)-.2);
  if (active(fmort_dev))
    fpen+= norm2(fmort_dev);
  f+= fpen;
  f+= sprpen;
}

void model_parameters::MCWrite(void)
{
  proyecciones();
  ofstream out("sardinamcmc.cvs",ios::app);
  out <<
  rbmsylast <<","<<
  Fmsylast <<","<<
  bmsy <<","<<
  So <<","<<
  catch_future(1,styr_fut)<<","<<
  catch_future(2,styr_fut)<<","<<
  catch_future(3,styr_fut)<<","<<
  catch_future(4,styr_fut)<<","<<
  "0"<<","<<
  catch_future(1,styr_fut+1)<<","<<
  catch_future(2,styr_fut+1)<<","<<
  catch_future(3,styr_fut+1)<<","<<
  catch_future(4,styr_fut+1)<<","<<
  "0"<<","<<
  catch_future(1,styr_fut+2)<<","<<
  catch_future(2,styr_fut+2)<<","<<
  catch_future(3,styr_fut+2)<<","<<
  catch_future(4,styr_fut+2)<<","<<
  "0"<<","<<
  catch_future(1,styr_fut+3)<<","<<
  catch_future(2,styr_fut+3)<<","<<
  catch_future(3,styr_fut+3)<<","<<
  catch_future(4,styr_fut+3)<<","<<
  "0"<<","<<  
  catch_future(1,styr_fut+4)<<","<<
  catch_future(2,styr_fut+4)<<","<<
  catch_future(3,styr_fut+4)<<","<<
  catch_future(4,styr_fut+4)<<","<<
  "0"<<","<<   
  catch_future(1,endyr_fut)<<","<<
  catch_future(2,endyr_fut)<<","<<
  catch_future(3,endyr_fut)<<","<<
  catch_future(4,endyr_fut)<<","<<
  "0"<<","<<
  future_ssbiom(1,styr_fut)<<","<<
  future_ssbiom(2,styr_fut)<<","<<
  future_ssbiom(3,styr_fut)<<","<<
  future_ssbiom(4,styr_fut)<<","<<
  future_ssbiom(5,styr_fut)<<","<<
  future_ssbiom(1,styr_fut+1)<<","<<
  future_ssbiom(2,styr_fut+1)<<","<<
  future_ssbiom(3,styr_fut+1)<<","<<
  future_ssbiom(4,styr_fut+1)<<","<<
  future_ssbiom(5,styr_fut+1)<<","<<
  future_ssbiom(1,styr_fut+2)<<","<<
  future_ssbiom(2,styr_fut+2)<<","<<
  future_ssbiom(3,styr_fut+2)<<","<<
  future_ssbiom(4,styr_fut+2)<<","<<
  future_ssbiom(5,styr_fut+2)<<","<<
  future_ssbiom(1,styr_fut+3)<<","<<
  future_ssbiom(2,styr_fut+3)<<","<<
  future_ssbiom(3,styr_fut+3)<<","<<
  future_ssbiom(4,styr_fut+3)<<","<<
  future_ssbiom(5,styr_fut+3)<<","<< 
  future_ssbiom(1,styr_fut+4)<<","<<
  future_ssbiom(2,styr_fut+4)<<","<<
  future_ssbiom(3,styr_fut+4)<<","<<
  future_ssbiom(4,styr_fut+4)<<","<<
  future_ssbiom(5,styr_fut+4)<<","<<    
  future_ssbiom(1,endyr_fut)<<","<<
  future_ssbiom(2,endyr_fut)<<","<<
  future_ssbiom(3,endyr_fut)<<","<<
  future_ssbiom(4,endyr_fut)<<","<<
  future_ssbiom(5,endyr_fut)<<","<<
  endl;
}

void model_parameters::report(const dvector& gradients)
{
 adstring ad_tmp=initial_params::get_reportfile_name();
  ofstream report((char*)(adprogram_name + ad_tmp));
  if (!report)
  {
    cerr << "error trying to open report file"  << adprogram_name << ".rep";
    return;
  }
    report << "$So" << endl;
    report << So << endl;
    report << "$F60" << endl;
    report << F60 << endl;
    report << "$residualcaptura" << endl;
    report << ssqcatch_residuals << endl;
    report << "$residualcpue" << endl;
    report << cpue_like_residuals << endl;
    report << "$residualreclas" << endl;
    report << surv_like_residuals << endl;
    report << "$residualpelaces" << endl;
    report << surv_like_residualspel << endl;
    report << "$Numerodepecesenelstock" << endl;
    report << natage << endl;
    report << "$Reclutamiento" << endl;
    report << BR << endl;
    report << "$Mortalidadporpesca " << endl;
    report << F << endl;
    report << "$SurveyObs" << endl;
    report << obs_surv << endl;
    report << "$SurveyEstReclas" << endl;
    report << pred_surv << endl;
    report << "$SurveyObsPelaces" << endl;
    report << obs_survpel << endl;
    report << "$SurveyEstPelaces" << endl;
    report << pred_survpel << endl;
    report << "$edad" << endl;
    report << edad << endl;
    report << "$yrsurv" << endl;
    report << yr_surv << endl;
    report << "$yrfish" << endl;
    report << yr_fishlen << endl;
    report << "$DatosobservadosCPUE" << endl;
    report << obs_cpue << endl;
    report << "$DatospredichosCPUE" << endl;
    report << pred_cpue << endl;
    report << "$Capturaobservada"<<endl;
    report << catch_bio << endl;
    report << "$Capturapredicha"<<endl;
    report << pred_catch << endl;
    report << "$Mortalidadporpescaanual"<< endl;
    report << Fmort <<endl;
    report << "$Biomasatotal "<<endl;
    report << totbiom <<endl;
    report << "$Biomasaadulta "<<endl;
    report << bioadul <<endl;
    report << "$Biomasadesovante "<<endl;
    report << ssbiom <<endl;
    report << "$potencialreproductivo "<<endl;
    report << RPR <<endl;
    report << "$Residualesproporcionpesqueria "<<endl;
    report << pred_p_residual <<endl;
    report << "$Residualesproporcionreclas "<<endl;
    report << pred_p_residualsreclas <<endl;
    report << "$Residualesproporcionpelaces "<<endl;
    report << pred_p_residualspelaces <<endl;
    report << "$Propobservada" <<endl;
    report << obs_p_len << endl;
    report << "$Proppredicha " <<endl;
    report << pred_p_len << endl;
    report << "$Propobservadar" <<endl;
    report << obs_p_lenreclas << endl;
    report << "$Proppredichar " <<endl;
    report << pred_p_lenreclas << endl;
    report << "$Propobservadap" <<endl;
    report << obs_p_lenpelaces << endl;
    report << "$Proppredichap " <<endl;
    report << pred_p_lenpelaces << endl;
    report << "$FuncionObjetivo "<<endl;
    report << f <<endl;
    report << "$selectividadreclas"<<endl;
    report << age_selr <<endl;
    report << "$selectividadpelaces "<<endl;
    report << age_selp <<endl;
    report << "$selectividadpesquerias "<<endl;
    report << age_sel <<endl;
    report << "$rbmsylast "<<endl;
    report << rbmsylast <<endl;
    report << "$Fmsylast "<<endl;
    report << Fmsylast <<endl;
    report << "$trans "<<endl;
    report << trans <<endl;
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{100, 400, 800, 800}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
  dvector temp("{1e-4,1e-6,1e-6, 1e-6}");
  convergence_criteria.allocate(temp.indexmin(),temp.indexmax());
  convergence_criteria=temp;
}

model_data::~model_data()
{}

model_parameters::~model_parameters()
{}

void model_parameters::final_calcs(void){}

#ifdef _BORLANDC_
  extern unsigned _stklen=10000U;
#endif


#ifdef __ZTC__
  extern unsigned int _stack=10000U;
#endif

  long int arrmblsize=0;

int main(int argc,char * argv[])
{
    ad_set_new_handler();
  ad_exit=&ad_boundf;
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(1000);
  gradient_structure::set_MAX_NVAR_OFFSET(10000);
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(300000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(6000000);
    gradient_structure::set_NO_DERIVATIVES();
#ifdef DEBUG
  #ifndef __SUNPRO_C
std::feclearexcept(FE_ALL_EXCEPT);
  #endif
#endif
    gradient_structure::set_YES_SAVE_VARIABLES_VALUES();
    if (!arrmblsize) arrmblsize=15000000;
    model_parameters mp(arrmblsize,argc,argv);
    mp.iprint=10;
    mp.preliminary_calculations();
    mp.computations(argc,argv);
#ifdef DEBUG
  #ifndef __SUNPRO_C
bool failedtest = false;
if (std::fetestexcept(FE_DIVBYZERO))
  { cerr << "Error: Detected division by zero." << endl; failedtest = true; }
if (std::fetestexcept(FE_INVALID))
  { cerr << "Error: Detected invalid argument." << endl; failedtest = true; }
if (std::fetestexcept(FE_OVERFLOW))
  { cerr << "Error: Detected overflow." << endl; failedtest = true; }
if (std::fetestexcept(FE_UNDERFLOW))
  { cerr << "Error: Detected underflow." << endl; }
if (failedtest) { std::abort(); } 
  #endif
#endif
    return 0;
}

extern "C"  {
  void ad_boundf(int i)
  {
    /* so we can stop here */
    exit(i);
  }
}

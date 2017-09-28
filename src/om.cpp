#ifdef DEBUG
  #ifndef __SUNPRO_C
    #include <cfenv>
    #include <cstdlib>
  #endif
#endif
  #include <admodel.h> 
  #include <string.h>
  #undef rep
  #define rep(object) report << #object "\n" << object << endl;
  adstring s_simname;
  adstring a_simname;
  adstring datafile_name;
  adstring ctlfile_name;
  #undef check
  #define check(object) input << #object "\n" << object << endl;
  ofstream input("check_input.rep");
  
  //Mortalidad por pesca
  ofstream rep1("sben_fyr.mcmc",ios::app);
  ofstream rep2("erin_fyr.mcmc",ios::app);
  //Catch
  ofstream rep3("sben_cyr.mcmc",ios::app);
  ofstream rep4("erin_cyr.mcmc",ios::app);
  
  //SSB
  ofstream rep5("sben_syr.mcmc",ios::app);
  ofstream rep6("erin_syr.mcmc",ios::app);
  
  //Biomass
  ofstream rep7("sben_byr.mcmc",ios::app);
  ofstream rep8("erin_byr.mcmc",ios::app);
  //ratio ssb
  ofstream reprat1("s_ssb_rat1.mcmc",ios::app);
  ofstream reprat2("a_ssb_rat1.mcmc",ios::app);
  ofstream reprat3("s_ssb_rat2.mcmc",ios::app);
  ofstream reprat4("a_ssb_rat2.mcmc",ios::app);
  ofstream reprat5("s_ssb_rat3.mcmc",ios::app);
  ofstream reprat6("a_ssb_rat3.mcmc",ios::app);
  ofstream reprat7("s_rpr.mcmc",ios::app);
  ofstream reprat8("a_rpr.mcmc",ios::app);
  #undef mcrep
  #define mcrep(object) mcout << object << " ";
  ofstream mcout("mcmc.rep");
   
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <om.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
 *(ad_comm::global_datafile) >>  datafile_name; // First line is datafile 
 *(ad_comm::global_datafile) >>  ctlfile_name; // First line is datafile 
ad_comm::change_datafile_name(datafile_name);
long int lseed=iseed;
  pad_rng = new random_number_generator(iseed);;
  debug.allocate("debug");
  nyr.allocate("nyr");
  styr.allocate("styr");
  endyr.allocate("endyr");
  years.allocate(styr,endyr);
 years.fill_seqadd(styr,1);
  t_obs_catch.allocate(styr,endyr,"t_obs_catch");
  s_obs_catch.allocate(styr,endyr,"s_obs_catch");
  a_obs_catch.allocate(styr,endyr,"a_obs_catch");
  nobs_reclas.allocate("nobs_reclas");
  yrs_reclas.allocate(1,nobs_reclas,"yrs_reclas");
  s_obs_reclas.allocate(1,nobs_reclas,"s_obs_reclas");
  a_obs_reclas.allocate(1,nobs_reclas,"a_obs_reclas");
  t_obs_reclas.allocate(1,nobs_reclas,"t_obs_reclas");
  nobs_pel.allocate("nobs_pel");
  yrs_pel.allocate(1,nobs_pel,"yrs_pel");
  s_obs_pel.allocate(1,nobs_pel,"s_obs_pel");
  a_obs_pel.allocate(1,nobs_pel,"a_obs_pel");
  t_obs_pel.allocate(1,nobs_pel,"t_obs_pel");
  check(nyr);
  check(styr);
  check(endyr);
  check(years);
  check(t_obs_catch);
  check(s_obs_catch);
  check(a_obs_catch);
  check(nobs_reclas);
  check(yrs_reclas);
  check(s_obs_reclas);
  check(a_obs_reclas);
  check(t_obs_reclas);
  check(nobs_pel);
  check(yrs_pel);
  check(s_obs_pel);
  check(a_obs_pel);
  check(t_obs_pel);
  nobs_mph.allocate("nobs_mph");
  yrs_mph.allocate(1,nobs_mph,"yrs_mph");
  s_obs_mph.allocate(1,nobs_mph,"s_obs_mph");
  a_obs_mph.allocate(1,nobs_mph,"a_obs_mph");
  t_obs_mph.allocate(1,nobs_mph,"t_obs_mph");
  nobs_effort.allocate("nobs_effort");
  yrs_effort.allocate(1,nobs_effort,"yrs_effort");
  obs_effort.allocate(1,nobs_effort,"obs_effort");
  check(nobs_mph);
  check(yrs_mph);
  check(s_obs_mph);
  check(a_obs_mph);
  check(t_obs_mph);
  check(nobs_effort);
  check(yrs_effort);
  check(obs_effort);
  nlen.allocate("nlen");
  s_nobs_lfdfish.allocate("s_nobs_lfdfish");
  s_yrs_lfdfish.allocate(1,s_nobs_lfdfish,"s_yrs_lfdfish");
  s_obs_p_len_fish.allocate(1,s_nobs_lfdfish,1,nlen,"s_obs_p_len_fish");
  a_nobs_lfdfish.allocate("a_nobs_lfdfish");
  a_yrs_lfdfish.allocate(1,a_nobs_lfdfish,"a_yrs_lfdfish");
  a_obs_p_len_fish.allocate(1,a_nobs_lfdfish,1,nlen,"a_obs_p_len_fish");
  s_nobs_lfdrec.allocate("s_nobs_lfdrec");
  s_yrs_lfdrec.allocate(1,s_nobs_lfdrec,"s_yrs_lfdrec");
  s_obs_p_len_rec.allocate(1,s_nobs_lfdrec,1,nlen,"s_obs_p_len_rec");
  a_nobs_lfdrec.allocate("a_nobs_lfdrec");
  a_yrs_lfdrec.allocate(1,a_nobs_lfdrec,"a_yrs_lfdrec");
  a_obs_p_len_rec.allocate(1,a_nobs_lfdrec,1,nlen,"a_obs_p_len_rec");
  s_nobs_lfdpel.allocate("s_nobs_lfdpel");
  s_yrs_lfdpel.allocate(1,s_nobs_lfdpel,"s_yrs_lfdpel");
  s_obs_p_len_pel.allocate(1,s_nobs_lfdpel,1,nlen,"s_obs_p_len_pel");
  a_nobs_lfdpel.allocate("a_nobs_lfdpel");
  a_yrs_lfdpel.allocate(1,a_nobs_lfdpel,"a_yrs_lfdpel");
  a_obs_p_len_pel.allocate(1,a_nobs_lfdpel,1,nlen,"a_obs_p_len_pel");
  eof.allocate("eof");
  check(nlen);
  check(s_nobs_lfdfish);
  check(s_yrs_lfdfish);
  check(s_obs_p_len_fish);  
  check(a_nobs_lfdfish);
  check(a_yrs_lfdfish);
  check(a_obs_p_len_fish);  
  check(s_nobs_lfdrec);
  check(s_yrs_lfdrec);
  check(s_obs_p_len_rec);  
  check(a_nobs_lfdrec);
  check(a_yrs_lfdrec);
  check(a_obs_p_len_rec);  
  check(s_nobs_lfdpel);
  check(s_yrs_lfdpel);
  check(s_obs_p_len_pel);  
  check(a_nobs_lfdpel);
  check(a_yrs_lfdpel);
  check(a_obs_p_len_pel);
  check(eof);
ad_comm::change_datafile_name(ctlfile_name);
  nages.allocate("nages");
  h.allocate("h");
  len.allocate(1,nlen,"len");
  s_wt.allocate(1,nages,"s_wt");
  a_wt.allocate(1,nages,"a_wt");
  s_lt.allocate(1,nages,"s_lt");
  a_lt.allocate(1,nages,"a_lt");
  s_mat.allocate(1,nages,"s_mat");
  a_mat.allocate(1,nages,"a_mat");
  s_alk.allocate(1,nages,1,nlen,"s_alk");
  a_alk.allocate(1,nages,1,nlen,"a_alk");
  s_nfish.allocate("s_nfish");
  a_nfish.allocate("a_nfish");
  s_nreclas.allocate("s_nreclas");
  a_nreclas.allocate("a_nreclas");
  s_npelaces.allocate("s_npelaces");
  a_npelaces.allocate("a_npelaces");
  CV_y.allocate("CV_y");
  CV_r.allocate("CV_r");
  CV_p.allocate("CV_p");
  CV_d.allocate("CV_d");
  CV_e.allocate("CV_e");
  ph_sigmar.allocate("ph_sigmar");
  ph_Fdev.allocate("ph_Fdev");
  ph_recdev.allocate("ph_recdev");
  s_nselagef.allocate("s_nselagef");
  a_nselagef.allocate("a_nselagef");
  s_nselagesurv.allocate("s_nselagesurv");
  a_nselagesurv.allocate("a_nselagesurv");
  s_group_num_f.allocate("s_group_num_f");
  a_group_num_f.allocate("a_group_num_f");
  s_ph_sel_fish.allocate("s_ph_sel_fish");
  a_ph_sel_fish.allocate("a_ph_sel_fish");
  s_ph_sel_surv.allocate("s_ph_sel_surv");
  a_ph_sel_surv.allocate("a_ph_sel_surv");
  s_ph_seldev_f.allocate("s_ph_seldev_f");
  a_ph_seldev_f.allocate("a_ph_seldev_f");
  ph_rec_q.allocate("ph_rec_q");
  ph_pel_q.allocate("ph_pel_q");
  ph_q_effort.allocate("ph_q_effort");
   styr_rec=styr-nages+1;
   styr_fut=endyr+1;
   endyr_fut=styr_fut+5;
   phase_F40=5;
   num_str=3;
ad_comm::change_datafile_name("sardinareal.dat");
  s_styr.allocate("s_styr");
  s_endyr.allocate("s_endyr");
  s_nages.allocate("s_nages");
  s_catch_bio.allocate(s_styr,s_endyr,"s_catch_bio");
  s_nobs_cpue.allocate("s_nobs_cpue");
  s_yr_cpue.allocate(1,s_nobs_cpue,"s_yr_cpue");
  s_obs_cpue.allocate(1,s_nobs_cpue,"s_obs_cpue");
  s_nobs_surv.allocate("s_nobs_surv");
  s_yr_surv.allocate(1,s_nobs_surv,"s_yr_surv");
  s_obs_surv.allocate(1,s_nobs_surv,"s_obs_surv");
  s_nobs_survpel.allocate("s_nobs_survpel");
  s_yr_survpel.allocate(1,s_nobs_survpel,"s_yr_survpel");
  s_obs_survpel.allocate(1,s_nobs_survpel,"s_obs_survpel");
  s_nlenbins.allocate("s_nlenbins");
  s_nobs_fishlen.allocate("s_nobs_fishlen");
  s_yr_fishlen.allocate(1,s_nobs_fishlen,"s_yr_fishlen");
  s_obs_p_len.allocate(1,s_nobs_fishlen,1,s_nlenbins,"s_obs_p_len");
  s_opt_proy.allocate("s_opt_proy");
ad_comm::change_datafile_name("anchreal.dat");
  a_styr.allocate("a_styr");
  a_endyr.allocate("a_endyr");
  a_nages.allocate("a_nages");
  a_catch_bio.allocate(a_styr,a_endyr,"a_catch_bio");
  a_nobs_cpue.allocate("a_nobs_cpue");
  a_yr_cpue.allocate(1,a_nobs_cpue,"a_yr_cpue");
  a_obs_cpue.allocate(1,a_nobs_cpue,"a_obs_cpue");
  a_nobs_surv.allocate("a_nobs_surv");
  a_yr_surv.allocate(1,a_nobs_surv,"a_yr_surv");
  a_obs_surv.allocate(1,a_nobs_surv,"a_obs_surv");
  a_nobs_survpel.allocate("a_nobs_survpel");
  a_yr_survpel.allocate(1,a_nobs_survpel,"a_yr_survpel");
  a_obs_survpel.allocate(1,a_nobs_survpel,"a_obs_survpel");
  a_nlenbins.allocate("a_nlenbins");
  a_nobs_fishlen.allocate("a_nobs_fishlen");
  a_yr_fishlen.allocate(1,a_nobs_fishlen,"a_yr_fishlen");
  a_obs_p_len.allocate(1,a_nobs_fishlen,1,a_nlenbins,"a_obs_p_len");
  a_opt_proy.allocate("a_opt_proy");
opm=1;
  int s_if=0;
  int a_if=0;
  for (i=styr;i<endyr;i++)
   {
    if(!(i%s_group_num_f))
     {
       s_if++;
     }
   }
   s_dim_sel_f=s_if;
  for (i=styr;i<endyr;i++)
   {
    if(!(i%a_group_num_f))
     {
       a_if++;
     }
    }
    a_dim_sel_f=a_if;
}

void model_parameters::initializationfunction(void)
{
  s_natmort.set_initial_value(1);
  a_natmort.set_initial_value(0.7);
  log_R.set_initial_value(12);
  sigr.set_initial_value(0.8);
  sigr_ini.set_initial_value(0.8);
  s_log_avg_fmort.set_initial_value(-1.);
  a_log_avg_fmort.set_initial_value(-1.);
  s_log_q_reclas.set_initial_value(-0.001);
  a_log_q_reclas.set_initial_value(-0.001);
  s_log_q_pelaces.set_initial_value(-0.001);
  a_log_q_pelaces.set_initial_value(-0.001);
  s_log_q_mph.set_initial_value(-2);
  a_log_q_mph.set_initial_value(-2);
  prop.set_initial_value(0.5);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  s_log_q_reclas.allocate(ph_rec_q,"s_log_q_reclas");
  a_log_q_reclas.allocate(ph_rec_q,"a_log_q_reclas");
  s_log_q_pelaces.allocate(ph_pel_q,"s_log_q_pelaces");
  a_log_q_pelaces.allocate(ph_pel_q,"a_log_q_pelaces");
  s_log_q_mph.allocate(ph_pel_q,"s_log_q_mph");
  a_log_q_mph.allocate(ph_pel_q,"a_log_q_mph");
  s_natmort.allocate(-1,"s_natmort");
  a_natmort.allocate(-1,"a_natmort");
  natmort.allocate("natmort");
  #ifndef NO_AD_INITIALIZE
  natmort.initialize();
  #endif
  log_R.allocate(1,"log_R");
  s_rec_dev_ini.allocate(1,nages,-10,10,ph_recdev,"s_rec_dev_ini");
  a_rec_dev_ini.allocate(1,nages,-10,10,ph_recdev,"a_rec_dev_ini");
  rec_dev.allocate(styr+1,endyr,-10,10,ph_recdev,"rec_dev");
  sigr.allocate(0.01,2,ph_sigmar,"sigr");
  sigr_ini.allocate(0.01,2,ph_sigmar,"sigr_ini");
  prop.allocate(styr,endyr,0.001,0.999,4,"prop");
  s_R0.allocate("s_R0");
  #ifndef NO_AD_INITIALIZE
  s_R0.initialize();
  #endif
  s_S0.allocate("s_S0");
  #ifndef NO_AD_INITIALIZE
  s_S0.initialize();
  #endif
  a_R0.allocate("a_R0");
  #ifndef NO_AD_INITIALIZE
  a_R0.initialize();
  #endif
  a_S0.allocate("a_S0");
  #ifndef NO_AD_INITIALIZE
  a_S0.initialize();
  #endif
  S0.allocate("S0");
  #ifndef NO_AD_INITIALIZE
  S0.initialize();
  #endif
  s_alpha.allocate("s_alpha");
  #ifndef NO_AD_INITIALIZE
  s_alpha.initialize();
  #endif
  a_alpha.allocate("a_alpha");
  #ifndef NO_AD_INITIALIZE
  a_alpha.initialize();
  #endif
  s_beta.allocate("s_beta");
  #ifndef NO_AD_INITIALIZE
  s_beta.initialize();
  #endif
  a_beta.allocate("a_beta");
  #ifndef NO_AD_INITIALIZE
  a_beta.initialize();
  #endif
  s_neq.allocate(1,nages,"s_neq");
  #ifndef NO_AD_INITIALIZE
    s_neq.initialize();
  #endif
  a_neq.allocate(1,nages,"a_neq");
  #ifndef NO_AD_INITIALIZE
    a_neq.initialize();
  #endif
  s_log_avg_fmort.allocate(1,"s_log_avg_fmort");
  a_log_avg_fmort.allocate(1,"a_log_avg_fmort");
  s_fmort_dev.allocate(styr,endyr,-5,5,ph_Fdev,"s_fmort_dev");
  a_fmort_dev.allocate(styr,endyr,-5,5,ph_Fdev,"a_fmort_dev");
  sel_fish.allocate(styr,endyr,1,nages,"sel_fish");
  #ifndef NO_AD_INITIALIZE
    sel_fish.initialize();
  #endif
  s_log_selcoffs_f.allocate(1,s_nselagef,s_ph_sel_fish,"s_log_selcoffs_f");
  s_sel_devs_f.allocate(1,s_dim_sel_f,1,s_nselagef,-5,5,s_ph_seldev_f,"s_sel_devs_f");
  s_log_sel_f.allocate(styr,endyr,1,nages,"s_log_sel_f");
  #ifndef NO_AD_INITIALIZE
    s_log_sel_f.initialize();
  #endif
  s_sel_f.allocate(styr,endyr,1,nages,"s_sel_f");
  #ifndef NO_AD_INITIALIZE
    s_sel_f.initialize();
  #endif
  s_avgsel_fish.allocate("s_avgsel_fish");
  #ifndef NO_AD_INITIALIZE
  s_avgsel_fish.initialize();
  #endif
  a_log_selcoffs_f.allocate(1,a_nselagef,a_ph_sel_fish,"a_log_selcoffs_f");
  a_sel_devs_f.allocate(1,a_dim_sel_f,1,a_nselagef,-5,5,a_ph_seldev_f,"a_sel_devs_f");
  a_log_sel_f.allocate(styr,endyr,1,nages,"a_log_sel_f");
  #ifndef NO_AD_INITIALIZE
    a_log_sel_f.initialize();
  #endif
  a_sel_f.allocate(styr,endyr,1,nages,"a_sel_f");
  #ifndef NO_AD_INITIALIZE
    a_sel_f.initialize();
  #endif
  a_avgsel_fish.allocate("a_avgsel_fish");
  #ifndef NO_AD_INITIALIZE
  a_avgsel_fish.initialize();
  #endif
  s_log_selcoffs_reclas.allocate(1,s_nselagesurv,s_ph_sel_surv,"s_log_selcoffs_reclas");
  s_log_sel_reclas.allocate(1,nages,"s_log_sel_reclas");
  #ifndef NO_AD_INITIALIZE
    s_log_sel_reclas.initialize();
  #endif
  s_sel_reclas.allocate(1,nages,"s_sel_reclas");
  #ifndef NO_AD_INITIALIZE
    s_sel_reclas.initialize();
  #endif
  s_avgsel_reclas.allocate("s_avgsel_reclas");
  #ifndef NO_AD_INITIALIZE
  s_avgsel_reclas.initialize();
  #endif
  a_log_selcoffs_reclas.allocate(1,a_nselagesurv,a_ph_sel_surv,"a_log_selcoffs_reclas");
  a_log_sel_reclas.allocate(1,nages,"a_log_sel_reclas");
  #ifndef NO_AD_INITIALIZE
    a_log_sel_reclas.initialize();
  #endif
  a_sel_reclas.allocate(1,nages,"a_sel_reclas");
  #ifndef NO_AD_INITIALIZE
    a_sel_reclas.initialize();
  #endif
  a_avgsel_reclas.allocate("a_avgsel_reclas");
  #ifndef NO_AD_INITIALIZE
  a_avgsel_reclas.initialize();
  #endif
  s_log_selcoffs_pelaces.allocate(1,s_nselagesurv,s_ph_sel_surv,"s_log_selcoffs_pelaces");
  s_log_sel_pelaces.allocate(1,nages,"s_log_sel_pelaces");
  #ifndef NO_AD_INITIALIZE
    s_log_sel_pelaces.initialize();
  #endif
  s_sel_pelaces.allocate(1,nages,"s_sel_pelaces");
  #ifndef NO_AD_INITIALIZE
    s_sel_pelaces.initialize();
  #endif
  s_avgsel_pelaces.allocate("s_avgsel_pelaces");
  #ifndef NO_AD_INITIALIZE
  s_avgsel_pelaces.initialize();
  #endif
  a_log_selcoffs_pelaces.allocate(1,a_nselagesurv,a_ph_sel_surv,"a_log_selcoffs_pelaces");
  a_log_sel_pelaces.allocate(1,nages,"a_log_sel_pelaces");
  #ifndef NO_AD_INITIALIZE
    a_log_sel_pelaces.initialize();
  #endif
  a_sel_pelaces.allocate(1,nages,"a_sel_pelaces");
  #ifndef NO_AD_INITIALIZE
    a_sel_pelaces.initialize();
  #endif
  a_avgsel_pelaces.allocate("a_avgsel_pelaces");
  #ifndef NO_AD_INITIALIZE
  a_avgsel_pelaces.initialize();
  #endif
  natage.allocate(styr,endyr,1,nages,"natage");
  #ifndef NO_AD_INITIALIZE
    natage.initialize();
  #endif
  s_natage.allocate(styr,endyr,1,nages,"s_natage");
  #ifndef NO_AD_INITIALIZE
    s_natage.initialize();
  #endif
  a_natage.allocate(styr,endyr,1,nages,"a_natage");
  #ifndef NO_AD_INITIALIZE
    a_natage.initialize();
  #endif
  catage.allocate(styr,endyr,1,nages,"catage");
  #ifndef NO_AD_INITIALIZE
    catage.initialize();
  #endif
  s_catage.allocate(styr,endyr,1,nages,"s_catage");
  #ifndef NO_AD_INITIALIZE
    s_catage.initialize();
  #endif
  a_catage.allocate(styr,endyr,1,nages,"a_catage");
  #ifndef NO_AD_INITIALIZE
    a_catage.initialize();
  #endif
  Z.allocate(styr,endyr,1,nages,"Z");
  #ifndef NO_AD_INITIALIZE
    Z.initialize();
  #endif
  s_Z.allocate(styr,endyr,1,nages,"s_Z");
  #ifndef NO_AD_INITIALIZE
    s_Z.initialize();
  #endif
  a_Z.allocate(styr,endyr,1,nages,"a_Z");
  #ifndef NO_AD_INITIALIZE
    a_Z.initialize();
  #endif
  Ft.allocate(styr,endyr,1,nages,"Ft");
  #ifndef NO_AD_INITIALIZE
    Ft.initialize();
  #endif
  s_F.allocate(styr,endyr,1,nages,"s_F");
  #ifndef NO_AD_INITIALIZE
    s_F.initialize();
  #endif
  a_F.allocate(styr,endyr,1,nages,"a_F");
  #ifndef NO_AD_INITIALIZE
    a_F.initialize();
  #endif
  S.allocate(styr,endyr,1,nages,"S");
  #ifndef NO_AD_INITIALIZE
    S.initialize();
  #endif
  s_S.allocate(styr,endyr,1,nages,"s_S");
  #ifndef NO_AD_INITIALIZE
    s_S.initialize();
  #endif
  a_S.allocate(styr,endyr,1,nages,"a_S");
  #ifndef NO_AD_INITIALIZE
    a_S.initialize();
  #endif
  s_Sv.allocate(styr,endyr,1,nages,"s_Sv");
  #ifndef NO_AD_INITIALIZE
    s_Sv.initialize();
  #endif
  a_Sv.allocate(styr,endyr,1,nages,"a_Sv");
  #ifndef NO_AD_INITIALIZE
    a_Sv.initialize();
  #endif
  natsize.allocate(styr,endyr,1,nlen,"natsize");
  #ifndef NO_AD_INITIALIZE
    natsize.initialize();
  #endif
  s_natsize.allocate(styr,endyr,1,nlen,"s_natsize");
  #ifndef NO_AD_INITIALIZE
    s_natsize.initialize();
  #endif
  a_natsize.allocate(styr,endyr,1,nlen,"a_natsize");
  #ifndef NO_AD_INITIALIZE
    a_natsize.initialize();
  #endif
  s_Fmort.allocate(styr,endyr,"s_Fmort");
  #ifndef NO_AD_INITIALIZE
    s_Fmort.initialize();
  #endif
  a_Fmort.allocate(styr,endyr,"a_Fmort");
  #ifndef NO_AD_INITIALIZE
    a_Fmort.initialize();
  #endif
  s_biom.allocate(styr,endyr,"s_biom");
  #ifndef NO_AD_INITIALIZE
    s_biom.initialize();
  #endif
  a_biom.allocate(styr,endyr,"a_biom");
  #ifndef NO_AD_INITIALIZE
    a_biom.initialize();
  #endif
  biom.allocate(styr,endyr,"biom");
  #ifndef NO_AD_INITIALIZE
    biom.initialize();
  #endif
  s_biomad.allocate(styr,endyr,"s_biomad");
  #ifndef NO_AD_INITIALIZE
    s_biomad.initialize();
  #endif
  a_biomad.allocate(styr,endyr,"a_biomad");
  #ifndef NO_AD_INITIALIZE
    a_biomad.initialize();
  #endif
  s_ssb.allocate(styr,endyr,"s_ssb");
  #ifndef NO_AD_INITIALIZE
    s_ssb.initialize();
  #endif
  a_ssb.allocate(styr,endyr,"a_ssb");
  #ifndef NO_AD_INITIALIZE
    a_ssb.initialize();
  #endif
  ssb.allocate(styr,endyr,"ssb");
  #ifndef NO_AD_INITIALIZE
    ssb.initialize();
  #endif
  q_reclas.allocate("q_reclas");
  #ifndef NO_AD_INITIALIZE
  q_reclas.initialize();
  #endif
  s_q_reclas.allocate("s_q_reclas");
  #ifndef NO_AD_INITIALIZE
  s_q_reclas.initialize();
  #endif
  a_q_reclas.allocate("a_q_reclas");
  #ifndef NO_AD_INITIALIZE
  a_q_reclas.initialize();
  #endif
  q_pelaces.allocate("q_pelaces");
  #ifndef NO_AD_INITIALIZE
  q_pelaces.initialize();
  #endif
  s_q_pelaces.allocate("s_q_pelaces");
  #ifndef NO_AD_INITIALIZE
  s_q_pelaces.initialize();
  #endif
  a_q_pelaces.allocate("a_q_pelaces");
  #ifndef NO_AD_INITIALIZE
  a_q_pelaces.initialize();
  #endif
  q_mph.allocate("q_mph");
  #ifndef NO_AD_INITIALIZE
  q_mph.initialize();
  #endif
  s_q_mph.allocate("s_q_mph");
  #ifndef NO_AD_INITIALIZE
  s_q_mph.initialize();
  #endif
  a_q_mph.allocate("a_q_mph");
  #ifndef NO_AD_INITIALIZE
  a_q_mph.initialize();
  #endif
  surv.allocate("surv");
  #ifndef NO_AD_INITIALIZE
  surv.initialize();
  #endif
  pred_catch.allocate(styr,endyr,"pred_catch");
  #ifndef NO_AD_INITIALIZE
    pred_catch.initialize();
  #endif
  s_pred_catch.allocate(styr,endyr,"s_pred_catch");
  #ifndef NO_AD_INITIALIZE
    s_pred_catch.initialize();
  #endif
  a_pred_catch.allocate(styr,endyr,"a_pred_catch");
  #ifndef NO_AD_INITIALIZE
    a_pred_catch.initialize();
  #endif
  s_pred_reclas.allocate(1,nobs_reclas,"s_pred_reclas");
  #ifndef NO_AD_INITIALIZE
    s_pred_reclas.initialize();
  #endif
  s_pred_num_reclas.allocate(1,nobs_reclas,"s_pred_num_reclas");
  #ifndef NO_AD_INITIALIZE
    s_pred_num_reclas.initialize();
  #endif
  a_pred_reclas.allocate(1,nobs_reclas,"a_pred_reclas");
  #ifndef NO_AD_INITIALIZE
    a_pred_reclas.initialize();
  #endif
  a_pred_num_reclas.allocate(1,nobs_reclas,"a_pred_num_reclas");
  #ifndef NO_AD_INITIALIZE
    a_pred_num_reclas.initialize();
  #endif
  t_pred_reclas.allocate(1,nobs_reclas,"t_pred_reclas");
  #ifndef NO_AD_INITIALIZE
    t_pred_reclas.initialize();
  #endif
  s_pred_pelaces.allocate(1,nobs_pel,"s_pred_pelaces");
  #ifndef NO_AD_INITIALIZE
    s_pred_pelaces.initialize();
  #endif
  s_pred_num_pelaces.allocate(1,nobs_pel,"s_pred_num_pelaces");
  #ifndef NO_AD_INITIALIZE
    s_pred_num_pelaces.initialize();
  #endif
  a_pred_pelaces.allocate(1,nobs_pel,"a_pred_pelaces");
  #ifndef NO_AD_INITIALIZE
    a_pred_pelaces.initialize();
  #endif
  a_pred_num_pelaces.allocate(1,nobs_pel,"a_pred_num_pelaces");
  #ifndef NO_AD_INITIALIZE
    a_pred_num_pelaces.initialize();
  #endif
  t_pred_pelaces.allocate(1,nobs_pel,"t_pred_pelaces");
  #ifndef NO_AD_INITIALIZE
    t_pred_pelaces.initialize();
  #endif
  s_pred_mph.allocate(1,nobs_mph,"s_pred_mph");
  #ifndef NO_AD_INITIALIZE
    s_pred_mph.initialize();
  #endif
  s_pred_num_mph.allocate(1,nobs_mph,"s_pred_num_mph");
  #ifndef NO_AD_INITIALIZE
    s_pred_num_mph.initialize();
  #endif
  a_pred_mph.allocate(1,nobs_mph,"a_pred_mph");
  #ifndef NO_AD_INITIALIZE
    a_pred_mph.initialize();
  #endif
  a_pred_num_mph.allocate(1,nobs_mph,"a_pred_num_mph");
  #ifndef NO_AD_INITIALIZE
    a_pred_num_mph.initialize();
  #endif
  t_pred_mph.allocate(1,nobs_mph,"t_pred_mph");
  #ifndef NO_AD_INITIALIZE
    t_pred_mph.initialize();
  #endif
  s_pred_p_len_fish.allocate(1,s_nobs_lfdfish,1,nlen,"s_pred_p_len_fish");
  #ifndef NO_AD_INITIALIZE
    s_pred_p_len_fish.initialize();
  #endif
  a_pred_p_len_fish.allocate(1,a_nobs_lfdfish,1,nlen,"a_pred_p_len_fish");
  #ifndef NO_AD_INITIALIZE
    a_pred_p_len_fish.initialize();
  #endif
  s_pred_p_age_fish.allocate(1,s_nobs_lfdfish,1,nages,"s_pred_p_age_fish");
  #ifndef NO_AD_INITIALIZE
    s_pred_p_age_fish.initialize();
  #endif
  a_pred_p_age_fish.allocate(1,a_nobs_lfdfish,1,nages,"a_pred_p_age_fish");
  #ifndef NO_AD_INITIALIZE
    a_pred_p_age_fish.initialize();
  #endif
  s_pred_p_len_rec.allocate(1,s_nobs_lfdrec,1,nlen,"s_pred_p_len_rec");
  #ifndef NO_AD_INITIALIZE
    s_pred_p_len_rec.initialize();
  #endif
  a_pred_p_len_rec.allocate(1,a_nobs_lfdrec,1,nlen,"a_pred_p_len_rec");
  #ifndef NO_AD_INITIALIZE
    a_pred_p_len_rec.initialize();
  #endif
  s_pred_p_age_rec.allocate(1,s_nobs_lfdrec,1,nages,"s_pred_p_age_rec");
  #ifndef NO_AD_INITIALIZE
    s_pred_p_age_rec.initialize();
  #endif
  a_pred_p_age_rec.allocate(1,a_nobs_lfdrec,1,nages,"a_pred_p_age_rec");
  #ifndef NO_AD_INITIALIZE
    a_pred_p_age_rec.initialize();
  #endif
  s_pred_p_len_pel.allocate(1,s_nobs_lfdpel,1,nlen,"s_pred_p_len_pel");
  #ifndef NO_AD_INITIALIZE
    s_pred_p_len_pel.initialize();
  #endif
  a_pred_p_len_pel.allocate(1,a_nobs_lfdpel,1,nlen,"a_pred_p_len_pel");
  #ifndef NO_AD_INITIALIZE
    a_pred_p_len_pel.initialize();
  #endif
  s_pred_p_age_pel.allocate(1,s_nobs_lfdpel,1,nages,"s_pred_p_age_pel");
  #ifndef NO_AD_INITIALIZE
    s_pred_p_age_pel.initialize();
  #endif
  a_pred_p_age_pel.allocate(1,a_nobs_lfdpel,1,nages,"a_pred_p_age_pel");
  #ifndef NO_AD_INITIALIZE
    a_pred_p_age_pel.initialize();
  #endif
  ssqcatch.allocate(1,3,"ssqcatch");
  #ifndef NO_AD_INITIALIZE
    ssqcatch.initialize();
  #endif
  rec_like.allocate("rec_like");
  #ifndef NO_AD_INITIALIZE
  rec_like.initialize();
  #endif
  fpen.allocate(1,2,"fpen");
  #ifndef NO_AD_INITIALIZE
    fpen.initialize();
  #endif
  surv_like.allocate(1,9,"surv_like");
  #ifndef NO_AD_INITIALIZE
    surv_like.initialize();
  #endif
  offset.allocate(1,6,"offset");
  #ifndef NO_AD_INITIALIZE
    offset.initialize();
  #endif
  sel_like.allocate(1,2,"sel_like");
  #ifndef NO_AD_INITIALIZE
    sel_like.initialize();
  #endif
  sel_dev_like.allocate(1,2,"sel_dev_like");
  #ifndef NO_AD_INITIALIZE
    sel_dev_like.initialize();
  #endif
  s_sel_like_reclas.allocate("s_sel_like_reclas");
  #ifndef NO_AD_INITIALIZE
  s_sel_like_reclas.initialize();
  #endif
  a_sel_like_reclas.allocate("a_sel_like_reclas");
  #ifndef NO_AD_INITIALIZE
  a_sel_like_reclas.initialize();
  #endif
  s_sel_like_pel.allocate("s_sel_like_pel");
  #ifndef NO_AD_INITIALIZE
  s_sel_like_pel.initialize();
  #endif
  a_sel_like_pel.allocate("a_sel_like_pel");
  #ifndef NO_AD_INITIALIZE
  a_sel_like_pel.initialize();
  #endif
  age_like.allocate(1,6,"age_like");
  #ifndef NO_AD_INITIALIZE
    age_like.initialize();
  #endif
  prop_like.allocate("prop_like");
  #ifndef NO_AD_INITIALIZE
  prop_like.initialize();
  #endif
  sigmar.allocate("sigmar");
  #ifndef NO_AD_INITIALIZE
  sigmar.initialize();
  #endif
  sigmar_ini.allocate("sigmar_ini");
  #ifndef NO_AD_INITIALIZE
  sigmar_ini.initialize();
  #endif
  Kobs_tot_catch.allocate("Kobs_tot_catch");
  #ifndef NO_AD_INITIALIZE
  Kobs_tot_catch.initialize();
  #endif
  s_Kobs_tot_catch.allocate("s_Kobs_tot_catch");
  #ifndef NO_AD_INITIALIZE
  s_Kobs_tot_catch.initialize();
  #endif
  a_Kobs_tot_catch.allocate("a_Kobs_tot_catch");
  #ifndef NO_AD_INITIALIZE
  a_Kobs_tot_catch.initialize();
  #endif
  natage_future.allocate(styr_fut,endyr_fut,1,nages,"natage_future");
  #ifndef NO_AD_INITIALIZE
    natage_future.initialize();
  #endif
  s_natage_future.allocate(styr_fut,endyr_fut,1,nages,"s_natage_future");
  #ifndef NO_AD_INITIALIZE
    s_natage_future.initialize();
  #endif
  a_natage_future.allocate(styr_fut,endyr_fut,1,nages,"a_natage_future");
  #ifndef NO_AD_INITIALIZE
    a_natage_future.initialize();
  #endif
  s_natagev_fut.allocate(styr_fut,endyr_fut,1,nages,"s_natagev_fut");
  #ifndef NO_AD_INITIALIZE
    s_natagev_fut.initialize();
  #endif
  a_natagev_fut.allocate(styr_fut,endyr_fut,1,nages,"a_natagev_fut");
  #ifndef NO_AD_INITIALIZE
    a_natagev_fut.initialize();
  #endif
  F_future.allocate(styr_fut,endyr_fut,1,nages,"F_future");
  #ifndef NO_AD_INITIALIZE
    F_future.initialize();
  #endif
  s_F_future.allocate(styr_fut,endyr_fut,1,nages,"s_F_future");
  #ifndef NO_AD_INITIALIZE
    s_F_future.initialize();
  #endif
  a_F_future.allocate(styr_fut,endyr_fut,1,nages,"a_F_future");
  #ifndef NO_AD_INITIALIZE
    a_F_future.initialize();
  #endif
  Z_future.allocate(styr_fut,endyr_fut,1,nages,"Z_future");
  #ifndef NO_AD_INITIALIZE
    Z_future.initialize();
  #endif
  s_Z_future.allocate(styr_fut,endyr_fut,1,nages,"s_Z_future");
  #ifndef NO_AD_INITIALIZE
    s_Z_future.initialize();
  #endif
  a_Z_future.allocate(styr_fut,endyr_fut,1,nages,"a_Z_future");
  #ifndef NO_AD_INITIALIZE
    a_Z_future.initialize();
  #endif
  S_future.allocate(styr_fut,endyr_fut,1,nages,"S_future");
  #ifndef NO_AD_INITIALIZE
    S_future.initialize();
  #endif
  s_S_future.allocate(styr_fut,endyr_fut,1,nages,"s_S_future");
  #ifndef NO_AD_INITIALIZE
    s_S_future.initialize();
  #endif
  a_S_future.allocate(styr_fut,endyr_fut,1,nages,"a_S_future");
  #ifndef NO_AD_INITIALIZE
    a_S_future.initialize();
  #endif
  s_Sv_future.allocate(styr_fut,endyr_fut,1,nages,"s_Sv_future");
  #ifndef NO_AD_INITIALIZE
    s_Sv_future.initialize();
  #endif
  a_Sv_future.allocate(styr_fut,endyr_fut,1,nages,"a_Sv_future");
  #ifndef NO_AD_INITIALIZE
    a_Sv_future.initialize();
  #endif
  catage_future.allocate(styr_fut,endyr_fut,1,nages,"catage_future");
  #ifndef NO_AD_INITIALIZE
    catage_future.initialize();
  #endif
  s_catage_future.allocate(styr_fut,endyr_fut,1,nages,"s_catage_future");
  #ifndef NO_AD_INITIALIZE
    s_catage_future.initialize();
  #endif
  a_catage_future.allocate(styr_fut,endyr_fut,1,nages,"a_catage_future");
  #ifndef NO_AD_INITIALIZE
    a_catage_future.initialize();
  #endif
  biomass_future.allocate(styr_fut,endyr_fut,"biomass_future");
  #ifndef NO_AD_INITIALIZE
    biomass_future.initialize();
  #endif
  s_biomass_future.allocate(styr_fut,endyr_fut,"s_biomass_future");
  #ifndef NO_AD_INITIALIZE
    s_biomass_future.initialize();
  #endif
  a_biomass_future.allocate(styr_fut,endyr_fut,"a_biomass_future");
  #ifndef NO_AD_INITIALIZE
    a_biomass_future.initialize();
  #endif
  ssbiom_future.allocate(styr_fut,endyr_fut,"ssbiom_future");
  #ifndef NO_AD_INITIALIZE
    ssbiom_future.initialize();
  #endif
  s_ssbiom_future.allocate(styr_fut,endyr_fut,"s_ssbiom_future");
  #ifndef NO_AD_INITIALIZE
    s_ssbiom_future.initialize();
  #endif
  a_ssbiom_future.allocate(styr_fut,endyr_fut,"a_ssbiom_future");
  #ifndef NO_AD_INITIALIZE
    a_ssbiom_future.initialize();
  #endif
  s_ssbv_future.allocate(styr_fut,endyr_fut,"s_ssbv_future");
  #ifndef NO_AD_INITIALIZE
    s_ssbv_future.initialize();
  #endif
  a_ssbv_future.allocate(styr_fut,endyr_fut,"a_ssbv_future");
  #ifndef NO_AD_INITIALIZE
    a_ssbv_future.initialize();
  #endif
  expl_biom.allocate(styr_fut,endyr_fut,"expl_biom");
  #ifndef NO_AD_INITIALIZE
    expl_biom.initialize();
  #endif
  s_expl_biom.allocate(styr_fut,endyr_fut,"s_expl_biom");
  #ifndef NO_AD_INITIALIZE
    s_expl_biom.initialize();
  #endif
  a_expl_biom.allocate(styr_fut,endyr_fut,"a_expl_biom");
  #ifndef NO_AD_INITIALIZE
    a_expl_biom.initialize();
  #endif
  s_sim_p_fishage.allocate(styr_fut,endyr_fut,1,nages,"s_sim_p_fishage");
  #ifndef NO_AD_INITIALIZE
    s_sim_p_fishage.initialize();
  #endif
  a_sim_p_fishage.allocate(styr_fut,endyr_fut,1,nages,"a_sim_p_fishage");
  #ifndef NO_AD_INITIALIZE
    a_sim_p_fishage.initialize();
  #endif
  s_sim_p_recage.allocate(styr_fut,endyr_fut,1,nages,"s_sim_p_recage");
  #ifndef NO_AD_INITIALIZE
    s_sim_p_recage.initialize();
  #endif
  a_sim_p_recage.allocate(styr_fut,endyr_fut,1,nages,"a_sim_p_recage");
  #ifndef NO_AD_INITIALIZE
    a_sim_p_recage.initialize();
  #endif
  s_sim_p_pelage.allocate(styr_fut,endyr_fut,1,nages,"s_sim_p_pelage");
  #ifndef NO_AD_INITIALIZE
    s_sim_p_pelage.initialize();
  #endif
  a_sim_p_pelage.allocate(styr_fut,endyr_fut,1,nages,"a_sim_p_pelage");
  #ifndef NO_AD_INITIALIZE
    a_sim_p_pelage.initialize();
  #endif
  s_sim_p_fishlen.allocate(styr_fut,endyr_fut,1,s_nlenbins,"s_sim_p_fishlen");
  #ifndef NO_AD_INITIALIZE
    s_sim_p_fishlen.initialize();
  #endif
  a_sim_p_fishlen.allocate(styr_fut,endyr_fut,1,s_nlenbins,"a_sim_p_fishlen");
  #ifndef NO_AD_INITIALIZE
    a_sim_p_fishlen.initialize();
  #endif
  s_sim_p_reclen.allocate(styr_fut,endyr_fut,1,s_nlenbins,"s_sim_p_reclen");
  #ifndef NO_AD_INITIALIZE
    s_sim_p_reclen.initialize();
  #endif
  a_sim_p_reclen.allocate(styr_fut,endyr_fut,1,s_nlenbins,"a_sim_p_reclen");
  #ifndef NO_AD_INITIALIZE
    a_sim_p_reclen.initialize();
  #endif
  s_sim_p_pellen.allocate(styr_fut,endyr_fut,1,s_nlenbins,"s_sim_p_pellen");
  #ifndef NO_AD_INITIALIZE
    s_sim_p_pellen.initialize();
  #endif
  a_sim_p_pellen.allocate(styr_fut,endyr_fut,1,a_nlenbins,"a_sim_p_pellen");
  #ifndef NO_AD_INITIALIZE
    a_sim_p_pellen.initialize();
  #endif
  s_sim_HB.allocate(styr_fut,endyr_fut,"s_sim_HB");
  #ifndef NO_AD_INITIALIZE
    s_sim_HB.initialize();
  #endif
  a_sim_HB.allocate(styr_fut,endyr_fut,"a_sim_HB");
  #ifndef NO_AD_INITIALIZE
    a_sim_HB.initialize();
  #endif
  s_sim_HB2.allocate(styr_fut,endyr_fut,"s_sim_HB2");
  #ifndef NO_AD_INITIALIZE
    s_sim_HB2.initialize();
  #endif
  a_sim_HB2.allocate(styr_fut,endyr_fut,"a_sim_HB2");
  #ifndef NO_AD_INITIALIZE
    a_sim_HB2.initialize();
  #endif
  s_sim_MPH.allocate(styr_fut,endyr_fut,"s_sim_MPH");
  #ifndef NO_AD_INITIALIZE
    s_sim_MPH.initialize();
  #endif
  a_sim_MPH.allocate(styr_fut,endyr_fut,"a_sim_MPH");
  #ifndef NO_AD_INITIALIZE
    a_sim_MPH.initialize();
  #endif
  s_sim_cpue.allocate(styr_fut,endyr_fut,"s_sim_cpue");
  #ifndef NO_AD_INITIALIZE
    s_sim_cpue.initialize();
  #endif
  a_sim_cpue.allocate(styr_fut,endyr_fut,"a_sim_cpue");
  #ifndef NO_AD_INITIALIZE
    a_sim_cpue.initialize();
  #endif
  new_rec_epsilon.allocate(styr_fut,endyr_fut,"new_rec_epsilon");
  #ifndef NO_AD_INITIALIZE
    new_rec_epsilon.initialize();
  #endif
  new_prop.allocate(styr_fut,endyr_fut,"new_prop");
  #ifndef NO_AD_INITIALIZE
    new_prop.initialize();
  #endif
  s_reclas_epsilon.allocate(styr_fut,endyr_fut,"s_reclas_epsilon");
  #ifndef NO_AD_INITIALIZE
    s_reclas_epsilon.initialize();
  #endif
  a_reclas_epsilon.allocate(styr_fut,endyr_fut,"a_reclas_epsilon");
  #ifndef NO_AD_INITIALIZE
    a_reclas_epsilon.initialize();
  #endif
  s_pelaces_epsilon.allocate(styr_fut,endyr_fut,"s_pelaces_epsilon");
  #ifndef NO_AD_INITIALIZE
    s_pelaces_epsilon.initialize();
  #endif
  a_pelaces_epsilon.allocate(styr_fut,endyr_fut,"a_pelaces_epsilon");
  #ifndef NO_AD_INITIALIZE
    a_pelaces_epsilon.initialize();
  #endif
  s_mph_epsilon.allocate(styr_fut,endyr_fut,"s_mph_epsilon");
  #ifndef NO_AD_INITIALIZE
    s_mph_epsilon.initialize();
  #endif
  a_mph_epsilon.allocate(styr_fut,endyr_fut,"a_mph_epsilon");
  #ifndef NO_AD_INITIALIZE
    a_mph_epsilon.initialize();
  #endif
  s_cpue_epsilon.allocate(styr_fut,endyr_fut,"s_cpue_epsilon");
  #ifndef NO_AD_INITIALIZE
    s_cpue_epsilon.initialize();
  #endif
  a_cpue_epsilon.allocate(styr_fut,endyr_fut,"a_cpue_epsilon");
  #ifndef NO_AD_INITIALIZE
    a_cpue_epsilon.initialize();
  #endif
  init_catch_future.allocate(1,num_str,styr_fut,endyr_fut,"init_catch_future");
  #ifndef NO_AD_INITIALIZE
    init_catch_future.initialize();
  #endif
  s_init_catch_future.allocate(1,num_str,styr_fut,endyr_fut,"s_init_catch_future");
  #ifndef NO_AD_INITIALIZE
    s_init_catch_future.initialize();
  #endif
  a_init_catch_future.allocate(1,num_str,styr_fut,endyr_fut,"a_init_catch_future");
  #ifndef NO_AD_INITIALIZE
    a_init_catch_future.initialize();
  #endif
  catch_future.allocate(1,num_str,styr_fut,endyr_fut,"catch_future");
  #ifndef NO_AD_INITIALIZE
    catch_future.initialize();
  #endif
  s_catch_future.allocate(1,num_str,styr_fut,endyr_fut,"s_catch_future");
  #ifndef NO_AD_INITIALIZE
    s_catch_future.initialize();
  #endif
  a_catch_future.allocate(1,num_str,styr_fut,endyr_fut,"a_catch_future");
  #ifndef NO_AD_INITIALIZE
    a_catch_future.initialize();
  #endif
  prop_fin_scatch_est_future.allocate(1,num_str,styr_fut,endyr_fut,"prop_fin_scatch_est_future");
  #ifndef NO_AD_INITIALIZE
    prop_fin_scatch_est_future.initialize();
  #endif
  prop_ini_scatch_est_future.allocate(1,num_str,styr_fut,endyr_fut,"prop_ini_scatch_est_future");
  #ifndef NO_AD_INITIALIZE
    prop_ini_scatch_est_future.initialize();
  #endif
  prop_srecl_mop_future.allocate(1,num_str,styr_fut,endyr_fut,"prop_srecl_mop_future");
  #ifndef NO_AD_INITIALIZE
    prop_srecl_mop_future.initialize();
  #endif
  prop_scatch_mop_future.allocate(1,num_str,styr_fut,endyr_fut,"prop_scatch_mop_future");
  #ifndef NO_AD_INITIALIZE
    prop_scatch_mop_future.initialize();
  #endif
  future_biomass.allocate(1,num_str,styr_fut,endyr_fut,"future_biomass");
  #ifndef NO_AD_INITIALIZE
    future_biomass.initialize();
  #endif
  s_future_biomass.allocate(1,num_str,styr_fut,endyr_fut,"s_future_biomass");
  #ifndef NO_AD_INITIALIZE
    s_future_biomass.initialize();
  #endif
  a_future_biomass.allocate(1,num_str,styr_fut,endyr_fut,"a_future_biomass");
  #ifndef NO_AD_INITIALIZE
    a_future_biomass.initialize();
  #endif
  future_ssbiom.allocate(1,num_str,styr_fut,endyr_fut,"future_ssbiom");
  #ifndef NO_AD_INITIALIZE
    future_ssbiom.initialize();
  #endif
  s_future_ssbiom.allocate(1,num_str,styr_fut,endyr_fut,"s_future_ssbiom");
  #ifndef NO_AD_INITIALIZE
    s_future_ssbiom.initialize();
  #endif
  a_future_ssbiom.allocate(1,num_str,styr_fut,endyr_fut,"a_future_ssbiom");
  #ifndef NO_AD_INITIALIZE
    a_future_ssbiom.initialize();
  #endif
  Fyr_future.allocate(1,num_str,styr_fut,endyr_fut,"Fyr_future");
  #ifndef NO_AD_INITIALIZE
    Fyr_future.initialize();
  #endif
  s_Fyr_future.allocate(1,num_str,styr_fut,endyr_fut,"s_Fyr_future");
  #ifndef NO_AD_INITIALIZE
    s_Fyr_future.initialize();
  #endif
  a_Fyr_future.allocate(1,num_str,styr_fut,endyr_fut,"a_Fyr_future");
  #ifndef NO_AD_INITIALIZE
    a_Fyr_future.initialize();
  #endif
  ssb1_ratio.allocate(1,num_str,styr_fut,endyr_fut,"ssb1_ratio");
  #ifndef NO_AD_INITIALIZE
    ssb1_ratio.initialize();
  #endif
  s_ssb1_ratio.allocate(1,num_str,styr_fut,endyr_fut,"s_ssb1_ratio");
  #ifndef NO_AD_INITIALIZE
    s_ssb1_ratio.initialize();
  #endif
  a_ssb1_ratio.allocate(1,num_str,styr_fut,endyr_fut,"a_ssb1_ratio");
  #ifndef NO_AD_INITIALIZE
    a_ssb1_ratio.initialize();
  #endif
  ssb2_ratio.allocate(1,num_str,styr_fut,endyr_fut,"ssb2_ratio");
  #ifndef NO_AD_INITIALIZE
    ssb2_ratio.initialize();
  #endif
  s_ssb2_ratio.allocate(1,num_str,styr_fut,endyr_fut,"s_ssb2_ratio");
  #ifndef NO_AD_INITIALIZE
    s_ssb2_ratio.initialize();
  #endif
  a_ssb2_ratio.allocate(1,num_str,styr_fut,endyr_fut,"a_ssb2_ratio");
  #ifndef NO_AD_INITIALIZE
    a_ssb2_ratio.initialize();
  #endif
  ssb3_ratio.allocate(1,num_str,styr_fut,endyr_fut,"ssb3_ratio");
  #ifndef NO_AD_INITIALIZE
    ssb3_ratio.initialize();
  #endif
  s_ssb3_ratio.allocate(1,num_str,styr_fut,endyr_fut,"s_ssb3_ratio");
  #ifndef NO_AD_INITIALIZE
    s_ssb3_ratio.initialize();
  #endif
  a_ssb3_ratio.allocate(1,num_str,styr_fut,endyr_fut,"a_ssb3_ratio");
  #ifndef NO_AD_INITIALIZE
    a_ssb3_ratio.initialize();
  #endif
  ssb4_ratio.allocate(1,num_str,styr_fut,endyr_fut,"ssb4_ratio");
  #ifndef NO_AD_INITIALIZE
    ssb4_ratio.initialize();
  #endif
  s_ssb4_ratio.allocate(1,num_str,styr_fut,endyr_fut,"s_ssb4_ratio");
  #ifndef NO_AD_INITIALIZE
    s_ssb4_ratio.initialize();
  #endif
  a_ssb4_ratio.allocate(1,num_str,styr_fut,endyr_fut,"a_ssb4_ratio");
  #ifndef NO_AD_INITIALIZE
    a_ssb4_ratio.initialize();
  #endif
  ssb5_ratio.allocate(1,num_str,styr_fut,endyr_fut,"ssb5_ratio");
  #ifndef NO_AD_INITIALIZE
    ssb5_ratio.initialize();
  #endif
  s_ssb5_ratio.allocate(1,num_str,styr_fut,endyr_fut,"s_ssb5_ratio");
  #ifndef NO_AD_INITIALIZE
    s_ssb5_ratio.initialize();
  #endif
  a_ssb5_ratio.allocate(1,num_str,styr_fut,endyr_fut,"a_ssb5_ratio");
  #ifndef NO_AD_INITIALIZE
    a_ssb5_ratio.initialize();
  #endif
  rprp.allocate(1,num_str,styr_fut,endyr_fut,"rprp");
  #ifndef NO_AD_INITIALIZE
    rprp.initialize();
  #endif
  s_rprp.allocate(1,num_str,styr_fut,endyr_fut,"s_rprp");
  #ifndef NO_AD_INITIALIZE
    s_rprp.initialize();
  #endif
  a_rprp.allocate(1,num_str,styr_fut,endyr_fut,"a_rprp");
  #ifndef NO_AD_INITIALIZE
    a_rprp.initialize();
  #endif
  avgssb.allocate("avgssb");
  #ifndef NO_AD_INITIALIZE
  avgssb.initialize();
  #endif
  s_avgssb.allocate("s_avgssb");
  #ifndef NO_AD_INITIALIZE
  s_avgssb.initialize();
  #endif
  a_avgssb.allocate("a_avgssb");
  #ifndef NO_AD_INITIALIZE
  a_avgssb.initialize();
  #endif
  endbiom.allocate("endbiom");
  s_endbio.allocate("s_endbio");
  a_endbio.allocate("a_endbio");
  recruits.allocate(styr,endyr,"recruits");
  biomass.allocate(styr,endyr,"biomass");
  f.allocate("f");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
  //Datos sardina
  for (i=1;i<=s_nobs_lfdfish;i++)
  {
   s_obs_p_len_fish(i)=s_obs_p_len_fish(i)/sum(s_obs_p_len_fish(i));
   for (j=1;j<=nlen;j++)
    {
      if (s_obs_p_len_fish(i,j)>0)
      {
       offset(1)-=s_nfish*s_obs_p_len_fish(i,j)*log(s_obs_p_len_fish(i,j));
      }
    }
  }
  //Datos anchoveta
  for (i=1;i<=a_nobs_lfdfish;i++)
  {
   a_obs_p_len_fish(i)=a_obs_p_len_fish(i)/sum(a_obs_p_len_fish(i));
   for (j=1;j<=nlen;j++)
    {
      if (a_obs_p_len_fish(i,j)>0)
      {
       offset(2)-=a_nfish*a_obs_p_len_fish(i,j)*log(a_obs_p_len_fish(i,j));
      }
    }
  }
  //==+==+==+Crucero+==+==+==
  //RECLAS
  for (i=1;i<=s_nobs_lfdrec;i++)
  {
   s_obs_p_len_rec(i)=s_obs_p_len_rec(i)/sum(s_obs_p_len_rec(i));
   for (j=1;j<=nlen;j++)
    {
      if(s_obs_p_len_rec(i,j)>0)
      {
       offset(3)-=s_nreclas*s_obs_p_len_rec(i,j)*log(s_obs_p_len_rec(i,j));
      }
    }
  }
  for (i=1;i<=a_nobs_lfdrec;i++)
  {
   a_obs_p_len_rec(i)=a_obs_p_len_rec(i)/sum(a_obs_p_len_rec(i));
   for (j=1;j<=nlen;j++)
    {
      if(a_obs_p_len_rec(i,j)>0)
      {
       offset(4)-=a_nreclas*a_obs_p_len_rec(i,j)*log(a_obs_p_len_rec(i,j));
      }
    }
  }
  //PELACES
  for (i=1;i<=s_nobs_lfdpel;i++)
  {
   s_obs_p_len_pel(i)=s_obs_p_len_pel(i)/sum(s_obs_p_len_pel(i));
   for (j=1;j<=nlen;j++)
    {
      if(s_obs_p_len_pel(i,j)>0)
      {
       offset(5)-=s_npelaces*s_obs_p_len_pel(i,j)*log(s_obs_p_len_pel(i,j));
      }
    }
  }
  for (i=1;i<=a_nobs_lfdpel;i++)
  {
   a_obs_p_len_pel(i)=a_obs_p_len_pel(i)/sum(a_obs_p_len_pel(i));
   for (j=1;j<=nlen;j++)
    {
      if (a_obs_p_len_pel(i,j)>0)
      {
       offset(6)-=a_npelaces*a_obs_p_len_pel(i,j)*log(a_obs_p_len_pel(i,j));
      }
    }
  }
  //cout << "s_obs_p_len_pel "<< s_obs_p_len_pel << endl;
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{200, 400, 600, 800, 800, 800}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
  dvector temp("{1e-5,1e-6,1e-7, 1e-7, 1e-7, 1e-7}");
  convergence_criteria.allocate(temp.indexmin(),temp.indexmax());
  convergence_criteria=temp;
}

void model_parameters::userfunction(void)
{
  f =0.0;
  random_number_generator& rng= *pad_rng;
  get_selectivity();
  get_mortality();
  get_numbers_at_age();
  get_catch_at_age();
  get_predicted_values();
  evaluate_the_objective_function();
  if(last_phase())
  {
	  S_R_parameters();
	  //Oper_Model();
  }
  if (mceval_phase())
  {
    write_mcmc_pars();
    // Oper_Model();
  }
}

void model_parameters::S_R_parameters(void)
{
  random_number_generator& rng= *pad_rng;
	s_R0 = mean(prop)*mfexp(log_R);
	a_R0 = (1-mean(prop))*mfexp(log_R);
	s_neq(1)=s_R0;
	a_neq(1)=a_R0;
  for(j=2;j<=nages;j++)
  {
    s_neq(j)=s_neq(j-1)*mfexp(-1.0*s_natmort);
		a_neq(j)=a_neq(j-1)*mfexp(-1.0*a_natmort);
  }
	s_S0=0;
	a_S0=0;
	for(j=1;j<=nages;j++)
  {
		s_S0+=s_neq(j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_natmort);
		a_S0+=a_neq(j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_natmort);
	}
	S0 = s_S0+a_S0;
  s_alpha = (s_S0/s_R0)*(1.0-h)/(4.0*h);
	a_alpha = (a_S0/a_R0)*(1.0-h)/(4.0*h);
  s_beta  = (5.0*h-1.0)/(4.0*h*s_R0);
	a_beta  = (5.0*h-1.0)/(4.0*h*a_R0);
	s_avgssb = mean(s_ssb(endyr-5,endyr));
	a_avgssb = mean(a_ssb(endyr-5,endyr));
	avgssb = mean(ssb(endyr-5,endyr));
}

void model_parameters::Oper_Model(void)
{
  random_number_generator& rng= *pad_rng;
	//Sardina
	dvector ran_rec_vect(styr_fut,endyr_fut); //Random para reclutamiento
	dvector ran_prop_vect(styr_fut,endyr_fut); //Random proporcion de reclutas
	dvector s_ran_reclas(styr_fut,endyr_fut);
	dvector s_ran_pelaces(styr_fut,endyr_fut);
	dvector s_ran_mph(styr_fut,endyr_fut);
	dvector a_ran_reclas(styr_fut,endyr_fut);
	dvector a_ran_pelaces(styr_fut,endyr_fut);
	dvector a_ran_mph(styr_fut,endyr_fut);
	dvector s_ran_cpue(styr_fut,endyr_fut); //Modelo con CPUE
	dvector a_ran_cpue(styr_fut,endyr_fut); //Modelo con CPUE
	dvariable s_q_cpue=0.0000045;
	dvariable a_q_cpue=0.000007;
	dvariable CV_cpue=0.2;
	int upk;
	int l;
	int k;
	int numyear;
	int sim_num_obs;
	dvector yrs(styr_fut,endyr_fut);
	s_simname = "sardina.dat"; //Datos simulados para el estimador de sardina
	a_simname = "anchoveta.dat"; //Datos simulados para el estimador de anchoveta
	//ofstream op_pry("optproy.dat",ios::app);
	//ofstream SaveOM1("IniProp_Out.csv",ios::app);
	ofstream SaveOM2("FinProp_Out.csv",ios::app);
	ofstream SaveOM3("InitProp_Out.csv",ios::app);
    int opt;
	dvector s_CatchIni(1,num_str);  //Dimension segun las estrategias disponibles 
	dvector a_CatchIni(1,num_str);  //Dimension segun las estrategias disponibles 
	dvector s_CatchNow(1,num_str);
	dvector a_CatchNow(1,num_str);
	//dvariable s_CTPini; //CTP inicial sardina
	//dvariable a_CTPini; //CTP inicial anchoveta
	dvector s_p(1,s_nlenbins); //vector de proporcion
	dvector a_p(1,a_nlenbins); //vector de proporcion
	dvector s_freq(1,s_nlenbins); //
	dvector a_freq(1,a_nlenbins); //
	//===== INICIO ALGORITMO
	ran_rec_vect.fill_randn(rng);
	ran_prop_vect.fill_randn(rng); //genera numeros aleatorios normal srd
	s_ran_reclas.fill_randn(rng);
	s_ran_pelaces.fill_randn(rng);
	s_ran_mph.fill_randn(rng);
	a_ran_reclas.fill_randn(rng);
	a_ran_pelaces.fill_randn(rng);
	a_ran_mph.fill_randn(rng);
	s_Sv_future=mfexp(-1.*s_natmort);
	a_Sv_future=mfexp(-1.*a_natmort);
	s_ran_cpue.fill_randn(rng);
	a_ran_cpue.fill_randn(rng);				
    //int rm=system("./RunOM.sh")
	int rv=system("sardina -nox -nohess -iprint 200");
	    rv=system("anchoveta -nox -nohess -iprint 200");
	//***** CICLO PARA EVALUAR n estrategias
	for(l=1;l<=num_str;l++)
	{
		//==== CICLO PARA CAPTURA INICIAL
	    for(i=styr_fut;i<=endyr_fut;i++)
		{
			//Desviaciones aleatorias log-normal para los indices
			new_rec_epsilon(i)=(mfexp(ran_rec_vect(i)*sigr)); //sigr asumiendo 
			new_prop(i)=mfexp(ran_prop_vect(i))/(1+exp(ran_prop_vect(i))); //proporcion logit
			s_reclas_epsilon(i)=(mfexp(s_ran_reclas(i)*CV_r));
			s_pelaces_epsilon(i)=(mfexp(s_ran_pelaces(i)*CV_p));
			s_mph_epsilon(i)=(mfexp(s_ran_mph(i)*CV_d));
			s_cpue_epsilon(i)=(mfexp(s_ran_cpue(i)*CV_cpue)); //Asume un CV=0.2 para la cpue
			a_reclas_epsilon(i)=(mfexp(a_ran_reclas(i)*CV_r));
			a_pelaces_epsilon(i)=(mfexp(a_ran_pelaces(i)*CV_p));
			a_mph_epsilon(i)=(mfexp(a_ran_mph(i)*CV_d));
			a_cpue_epsilon(i)=(mfexp(a_ran_cpue(i)*CV_cpue)); //Asume un CV=0.2 para la cpue
			//Lee la captura biologicamente aceptable de sardina
			ifstream s_CTP_tmp("sctpinit.dat");
			s_CTP_tmp >> s_CatchNow;
			s_CTP_tmp.close();
			s_catch_future(l,i)=s_CatchNow(l);
			//lee la estimacion de cuota de anchoveta
			ifstream a_CTP_tmp("actpinit.dat");
			a_CTP_tmp >> a_CatchNow;
			a_CTP_tmp.close();
			a_catch_future(l,i)=a_CatchNow(l);
			//Juntamos la cuota segun enfoque de Pesca Mixta
			//Ejemplo con cuota conjunta, la suma de las dos
			catch_future(l,i)=s_catch_future(l,i)+a_catch_future(l,i);
			//TODO: seleccion de criterio 
			prop_fin_scatch_est_future(l,i)=s_catch_future(l,i)/catch_future(l,i);
	        if(i<styr_fut+1)
			{
				//Se proyecta la condicion inicial sin reclutamiento de sardina
				s_natage_future(i)(2,nages)=++elem_prod(s_natage(i-1)(1,nages-1),s_S(i-1)(1,nages-1));
				a_natage_future(i)(2,nages)=++elem_prod(a_natage(i-1)(1,nages-1),a_S(i-1)(1,nages-1));
				s_natage_future(i,1)=new_prop(i)*mfexp(log_R)*new_rec_epsilon(i);
				a_natage_future(i,1)=(1-new_prop(i))*mfexp(log_R)*new_rec_epsilon(i);
				//numeros sin pesca
				s_natagev_fut(i)(2,nages)=++elem_prod(s_natage(i-1)(1,nages-1),s_Sv(i-1)(1,nages-1));
				a_natagev_fut(i)(2,nages)=++elem_prod(a_natage(i-1)(1,nages-1),a_Sv(i-1)(1,nages-1));
				s_natagev_fut(i,1)=s_natage_future(i,1);
				a_natagev_fut(i,1)=a_natage_future(i,1);				
				//TODO: modelar S-R proporcion asignada!!
				/*
			    if(SrType==1)
			    {  
			       natage_future(i,1)=(ssbiom(i-1)/(alpha + beta*ssbiom(i-1)))*new_ind(i);
			    }
			    else
			    {  
					natage_future(i,1)=(alpha*ssbiom(i-1)*mfexp(-beta*ssbiom(i-1)))*new_ind(i);
			    }
				*/
				//Guarda la proporcion de reclutamiento de sardina del Modelo Operativo
				prop_srecl_mop_future(l,i)=new_prop(i);
				//Guarda la proporcion teorica de captura
				prop_scatch_mop_future(l,i)=2.5*new_prop(i)-4.5*square(new_prop(i))+3*pow(new_prop(i),3);
				//Lee las CTPs finales de INPESCA
				s_expl_biom(i)=0.;
				a_expl_biom(i)=0.;
				expl_biom(i)=0.;
				for(j=1;j<=nages;j++)
				{
					s_expl_biom(i)+=s_sel_f(endyr,j)*s_wt(j)*s_natage_future(i,j);
					a_expl_biom(i)+=a_sel_f(endyr,j)*a_wt(j)*a_natage_future(i,j);
					expl_biom(i)+=a_expl_biom(i)+s_expl_biom(i);
				}
				//Simulacion de nuevos datos considerando la Mortalidad por Pesca generada por la captura
				s_biomass_future(i)=0.;
				a_biomass_future(i)=0.;
				s_sim_HB(i)=0.;		
				a_sim_HB(i)=0.;
				s_ssbv_future(i)=0.;
				a_ssbv_future(i)=0.;
				for(j=1;j<=nages;j++)
				{
					s_sim_p_recage(i,j)=s_sel_reclas(j)*s_natage_future(i,j); //Solucion exacta
					a_sim_p_recage(i,j)=a_sel_reclas(j)*a_natage_future(i,j); //Solucion exacta
					s_biomass_future(i)+=s_wt(j)*s_natage_future(i,j);  //biomasa
					a_biomass_future(i)+=a_wt(j)*a_natage_future(i,j);  //biomasa
					s_sim_HB(i)+=s_sel_reclas(j)*s_wt(j)*s_natage_future(i,j);//*s_reclas_epsilon(i);
					a_sim_HB(i)+=a_sel_reclas(j)*a_wt(j)*a_natage_future(i,j);//*a_reclas_epsilon(i);
					s_ssbv_future(i)+=s_natagev_fut(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_natmort);
					a_ssbv_future(i)+=a_natagev_fut(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_natmort);
				}
				//s_freq.initialize();
				//a_freq.initialize();
				//ivector s_bin(1,100);
				//ivector a_bin(1,100);
				s_sim_p_recage(i)=s_sim_p_recage(i)/sum(s_sim_p_recage(i));
				a_sim_p_recage(i)=a_sim_p_recage(i)/sum(a_sim_p_recage(i));
				s_sim_p_reclen(i)=s_sim_p_recage(i)*s_alk;
				a_sim_p_reclen(i)=a_sim_p_recage(i)*a_alk;
				//s_p = value(s_sim_p_reclen(i));
				// = value(a_sim_p_reclen(i));
				//s_p /=sum(s_p);
				//a_p /=sum(a_p);
				//s_bin.fill_multinomial(rng,s_p);
				//a_bin.fill_multinomial(rng,a_p);
				//for(j=1;j<=100;j++){s_freq(s_bin(j))++;a_freq(a_bin(j))++;}
				//s_p = s_freq/sum(s_freq);
				//a_p = a_freq/sum(a_freq);
				//s_sim_p_reclen(i)=s_p; //Composicion por tallas reclas
				//a_sim_p_reclen(i)=a_p;
				if(catch_future(l,i)!=0)
				{
					//Sardina 
					dvariable s_ffpen=0.0;
					dvariable s_SK=posfun((s_expl_biom(i)-s_catch_future(l,i))/s_expl_biom(i),0.05,s_ffpen);
					s_Kobs_tot_catch=s_expl_biom(i)-s_SK*s_expl_biom(i);
					do_Newton_Raphson_for_mortality1(i);					
					//Anchoveta
					dvariable a_ffpen=0.0;
					dvariable a_SK=posfun((a_expl_biom(i)-a_catch_future(l,i))/a_expl_biom(i),0.05,a_ffpen);
					a_Kobs_tot_catch=a_expl_biom(i)-a_SK*a_expl_biom(i);
					do_Newton_Raphson_for_mortality2(i);
					//Efecto total					
					dvariable ffpen=0.0;
					dvariable SK=posfun((expl_biom(i)-catch_future(l,i))/expl_biom(i),0.05,ffpen);
					Kobs_tot_catch=expl_biom(i)-SK*expl_biom(i);
					do_Newton_Raphson_for_mortality(i);					
				}
				else
				{
					s_F_future(i)=0.;
					a_F_future(i)=0.;
					F_future(i)=0.;
				}				
	            //cout << "s_F_future:"<< s_F_future <<endl;
	            //cout << "a_F_future:"<< a_F_future <<endl;
				//exit(1);
				s_Z_future(i)=s_F_future(i)+s_natmort;
				s_S_future(i)=exp(-1.*s_Z_future(i));
				s_Fyr_future(l,i)=max(s_F_future(i));
				a_Z_future(i)=a_F_future(i)+a_natmort;
				a_S_future(i)=exp(-1.*a_Z_future(i));
				a_Fyr_future(l,i)=max(a_F_future(i));
				Z_future(i)=F_future(i)+natmort;
				S_future(i)=exp(-1.*Z_future(i));
				Fyr_future(l,i)=max(F_future(i));				
				s_Sv_future(i)=mfexp(-1.*s_natmort);
				a_Sv_future(i)=mfexp(-1.*a_natmort);
				future_biomass(l,i)=0;
				future_ssbiom(l,i)=0;
				s_future_biomass(l,i)=0;
				s_future_ssbiom(l,i)=0;
				a_future_biomass(l,i)=0;
				a_future_ssbiom(l,i)=0;
				for(j=1;j<=nages;j++)
				{
					s_future_biomass(l,i)+=s_wt(j)*s_natage_future(i,j);
					s_future_ssbiom(l,i)+=s_natage_future(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_Z_future(i,j));
					a_future_biomass(l,i)+=a_wt(j)*a_natage_future(i,j);
					a_future_ssbiom(l,i)+=a_natage_future(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_Z_future(i,j));
					future_biomass(l,i)+=s_future_biomass(l,i)+a_future_biomass(l,i);
					future_ssbiom(l,i)+=s_future_ssbiom(l,i)+a_future_ssbiom(l,i);
				}
				s_ssb1_ratio(l,i)=s_future_ssbiom(l,i)/s_ssb(endyr);
				s_ssb2_ratio(l,i)=s_future_ssbiom(l,i)/s_avgssb;
				s_ssb3_ratio(l,i)=s_future_ssbiom(l,i)/s_S0;
				a_ssb1_ratio(l,i)=a_future_ssbiom(l,i)/a_ssb(endyr);
				a_ssb2_ratio(l,i)=a_future_ssbiom(l,i)/a_avgssb;
				a_ssb3_ratio(l,i)=a_future_ssbiom(l,i)/a_S0;
				ssb1_ratio(l,i)=future_ssbiom(l,i)/ssb(endyr);
				ssb2_ratio(l,i)=future_ssbiom(l,i)/avgssb;
				ssb3_ratio(l,i)=future_ssbiom(l,i)/(s_S0+a_S0);				
				s_rprp(l,i)=s_future_ssbiom(l,i)/s_ssbv_future(i);
				a_rprp(l,i)=a_future_ssbiom(l,i)/a_ssbv_future(i);
				rprp(l,i)=future_ssbiom(l,i)/(s_ssbv_future(i)+a_ssbv_future(i));
				//Recalcula los indices faltantes despues de la mortalidad por pesca generada por la CTP
				s_ssbiom_future(i)=0.;
				a_ssbiom_future(i)=0.;
				ssbiom_future(i)=0.;
				s_sim_HB2(i)=0.;
				a_sim_HB2(i)=0.;
				for(j=1;j<=nages;j++)
				{
					s_sim_p_fishage(i,j)=s_F_future(i,j)*s_natage_future(i,j)*(1-exp(-1.*s_Z_future(i,j)))/s_Z_future(i,j);
					a_sim_p_fishage(i,j)=a_F_future(i,j)*a_natage_future(i,j)*(1-exp(-1.*a_Z_future(i,j)))/a_Z_future(i,j);
					s_sim_p_pelage(i,j)=s_sel_pelaces(j)*s_natage_future(i,j)*mfexp(-0.375*s_Z_future(i,j));
					a_sim_p_pelage(i,j)=a_sel_pelaces(j)*a_natage_future(i,j)*mfexp(-0.375*a_Z_future(i,j));
					s_ssbiom_future(i)+=s_natage_future(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_Z_future(i,j));
					a_ssbiom_future(i)+=a_natage_future(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_Z_future(i,j));
					ssbiom_future(i)+=s_ssbiom_future(i)+a_ssbiom_future(i);
					s_sim_HB2(i)+=s_q_pelaces*s_sel_pelaces(j)*s_wt(j)*s_natage_future(i,j)*mfexp(-0.375*s_Z_future(i,j))*s_pelaces_epsilon(i);
					a_sim_HB2(i)+=a_q_pelaces*a_sel_pelaces(j)*a_wt(j)*a_natage_future(i,j)*mfexp(-0.375*a_Z_future(i,j))*a_pelaces_epsilon(i);
				}
				s_freq.initialize();
				a_freq.initialize();
				//ivector bin(1,100);
				s_sim_p_pelage(i)=s_sim_p_pelage(i)/sum(s_sim_p_pelage(i));
				s_sim_p_pellen(i)=s_sim_p_pelage(i)*s_alk;
				a_sim_p_pelage(i)=a_sim_p_pelage(i)/sum(a_sim_p_pelage(i));
				a_sim_p_pellen(i)=a_sim_p_pelage(i)*a_alk;
				//sardina
				/*
				s_p = value(s_sim_p_pellen(i));
				s_p /=sum(s_p);
				s_bin.fill_multinomial(rng,s_p);
				for(j=1;j<=100;j++){s_freq(s_bin(j))++;}
				s_p = s_freq/sum(s_freq);
				s_sim_p_pellen(i)=s_p;
				//anchoveta
				a_p = value(a_sim_p_pellen(i));
				a_p /=sum(a_p);
				a_bin.fill_multinomial(rng,a_p);
				for(j=1;j<=100;j++){a_freq(a_bin(j))++;}
				a_p = a_freq/sum(a_freq);
				a_sim_p_pellen(i)=a_p;
				*/
				//simula MPH			
				s_sim_MPH(i)=s_q_mph*s_ssbiom_future(i)*s_mph_epsilon(i);
				a_sim_MPH(i)=a_q_mph*a_ssbiom_future(i)*a_mph_epsilon(i);
				//simula CPUE
				s_sim_cpue(i)=s_q_cpue*s_expl_biom(i)*s_cpue_epsilon(i);
				a_sim_cpue(i)=a_q_cpue*a_expl_biom(i)*a_cpue_epsilon(i);
				//catch at length 
				s_freq.initialize();
				a_freq.initialize();
				//ivector bin(1,100);
				s_sim_p_fishage(i)=s_sim_p_fishage(i)/sum(s_sim_p_fishage(i));
				s_sim_p_fishlen(i)=s_sim_p_fishage(i)*s_alk;
				//s_p = value(s_sim_p_fishlen(i));
				//s_p /=sum(s_p);
				//s_bin.fill_multinomial(rng,s_p);
				//for(j=1;j<=100;j++){s_freq(s_bin(j))++;}
				//s_p = s_freq/sum(s_freq);
				//s_sim_p_fishlen(i)=s_p;
				//anchoveta
				a_sim_p_fishage(i)=a_sim_p_fishage(i)/sum(a_sim_p_fishage(i));
				a_sim_p_fishlen(i)=a_sim_p_fishage(i)*a_alk;
				//a_p = value(a_sim_p_fishlen(i));
				//a_p /=sum(a_p);
				//a_bin.fill_multinomial(rng,a_p);
				//for(j=1;j<=100;j++){a_freq(a_bin(j))++;}
				//a_p = a_freq/sum(a_freq);
				//a_sim_p_fishlen(i)=a_p;		
				//Ahora actualiza la evaluacion de sardina
				yrs(i)=i;
				upk = i;
				//numyear = yrs(i)-s_ystr+1;
				sim_num_obs = yrs(i)-styr_fut+1;
				//cout << "sim_num_obs"<< sim_num_obs << endl;
				opt=1;
				ofstream ssimdata(s_simname);
				ssimdata << "#Datos simulados para el estimador de sardina-INPESCA" <<endl;
				ssimdata << "#Inicial yr"<<endl;
				ssimdata << s_styr  << endl;
				ssimdata << "#Final yr"<<endl;
				ssimdata << yrs(i)  << endl;
				ssimdata << "#numages"<<endl;
				ssimdata << s_nages <<endl;
				ssimdata << "#Captura anual" <<endl;
				ssimdata << s_catch_bio <<endl; //Los datos historicos 1990-2010
                //agrega la captura next yr
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< s_catch_future(l,k) << endl; //Agrega la captura
				}				
				//agrega la cpue no actualizada
				ssimdata << "#Nobs_cpue"<< endl;
				ssimdata << s_nobs_cpue+sim_num_obs << endl;
				ssimdata << "#yrs con datos de cpue"<<endl;
				ssimdata << s_yr_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " " <<yrs(k) << endl; //Agrega y resta un yr
				}				
				ssimdata << "#CPUE"<<endl;
				ssimdata << s_obs_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< s_sim_cpue(k) << endl; //Agrega y resta un yr
				}
				//agrega la biomasa de reclas
				ssimdata << "#Nobs_survey"<< endl;
				ssimdata << s_nobs_surv+sim_num_obs << endl;
				ssimdata << "#yrs con datos de cpue"<<endl;
				ssimdata << s_yr_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< yrs(k) << endl; //Agrega y resta un yr
				}				
				ssimdata << "#Biomasa acustica reclas"<<endl;
				ssimdata << s_obs_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< s_sim_HB(k) << endl; //Agrega
				}
				//agrega la biomasa de pelaces
				ssimdata << "#Nobs_survey_pelaces"<< endl;
				ssimdata << s_nobs_survpel+sim_num_obs << endl;
				ssimdata << "#yrs con datos de cpue"<<endl;
				ssimdata << s_yr_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " " <<yrs(k) << endl; //Agrega
				}				
				ssimdata << "#Biomasa acustica pelaces"<<endl;
				ssimdata << s_obs_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " " << s_sim_HB2(k) << endl; //Agrega
				}
				//agrega los datos de compocisión por tallas
				ssimdata <<"#Num tallas"<<endl;
				ssimdata << s_nlenbins <<endl;
				ssimdata << "#Nobs comp tallas"<<endl;
				ssimdata << s_nobs_fishlen+sim_num_obs <<endl;
				ssimdata << "#yrs con lenfreq"<<endl;
				ssimdata << s_yr_fishlen << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " " <<yrs(k) << endl; //Agrega
				}
				ssimdata << "#Obs prop talla en la captura:"<<endl;
				ssimdata << " "<< s_obs_p_len << endl;
				for(k=styr_fut;k<=upk;k++)
				{
					ssimdata << s_sim_p_fishlen(k)<<endl;
				}
				ssimdata << "#Opts_proy" << endl;
				ssimdata << opt << endl;
				ssimdata.close();
				//AHORA escribe los datos para anchoveta
				ofstream asimdata(a_simname);
				asimdata << "#Datos simulados para el estimador de sardina-INPESCA"<<endl;
				asimdata << "#Inicial yr"<<endl;
				asimdata << a_styr  << endl;
				asimdata << "#Final yr"<<endl;
				asimdata << yrs(i)  << endl;
				asimdata << "#numages"<<endl;
				asimdata << a_nages <<endl;
				asimdata << "#Captura anual" <<endl;
				asimdata << a_catch_bio <<endl; //Los datos historicos 1990-2010
                //agrega la captura next yr
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " << a_catch_future(l,k) << endl; //Agrega la captura
				}				
				//agrega la cpue no actualizada
				asimdata << "#Nobs_cpue"<< endl;
				asimdata << a_nobs_cpue+sim_num_obs << endl;
				asimdata << "#yrs con datos de cpue"<<endl;
				asimdata << a_yr_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " "<< yrs(k) << endl; //Agrega y resta un yr
				}				
				asimdata << "#CPUE"<<endl;
				asimdata << a_obs_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<a_sim_cpue(k) << endl; //Agrega y resta un yr
				}
				//agrega la biomasa de reclas
				asimdata << "#Nobs_survey"<< endl;
				asimdata << a_nobs_surv+sim_num_obs << endl;
				asimdata << "#yrs con datos de cpue"<<endl;
				asimdata << a_yr_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << yrs(k) << endl; //Agrega y resta un yr
				}				
				asimdata << "#Biomasa acustica reclas"<<endl;
				asimdata << a_obs_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<a_sim_HB(k) << endl; //Agrega
				}
				//agrega la biomasa de pelaces
				asimdata << "#Nobs_survey_pelaces"<< endl;
				asimdata << a_nobs_survpel+sim_num_obs << endl;
				asimdata << "#yrs con datos de cpue"<<endl;
				asimdata << a_yr_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " "<<yrs(k) << endl; //Agrega
				}				
				asimdata << "#Biomasa acustica pelaces"<<endl;
				asimdata << a_obs_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " "<<a_sim_HB2(k) << endl; //Agrega
				}
				//agrega los datos de compocisión por tallas
				asimdata <<"#Num tallas"<<endl;
				asimdata << a_nlenbins <<endl;
				asimdata << "#Nobs comp tallas"<<endl;
				asimdata << a_nobs_fishlen+sim_num_obs <<endl;
				asimdata << "#yrs con lenfreq"<<endl;
				asimdata << a_yr_fishlen << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " "<<yrs(k) << endl; //Agrega
				}
				asimdata << "#Obs prop talla en la captura:"<<endl;
				asimdata << a_obs_p_len << endl;
				for(k=styr_fut;k<=upk;k++)
				{
					asimdata << " "<<a_sim_p_fishlen(k)<<endl;
				}
				asimdata << "#Opts_proy" << endl;
				asimdata << opt << endl;
				asimdata.close();
				//ahora corre el estimador para dejar preparada la con styr_fut
				rv=system("sardina -nox -nohess -iprint 200"); //// probar con anchoveta.exe
				rv=system("anchoveta -nox -nohess -iprint 200");//// probar con anchoveta.exe								
			}
			else
			{
        s_natage_future(i)(2,nages) =++elem_prod(s_natage_future(i-1)(1,nages-1),s_S_future(i-1)(1,nages-1));
        a_natage_future(i)(2,nages) =++elem_prod(a_natage_future(i-1)(1,nages-1),a_S_future(i-1)(1,nages-1));
        s_natage_future(i,1)        =new_prop(i)*mfexp(log_R)*new_rec_epsilon(i);
        a_natage_future(i,1)        =(1-new_prop(i))*mfexp(log_R)*new_rec_epsilon(i);
        //numeros sin pesca
        s_natagev_fut(i)(2,nages)   =++elem_prod(s_natagev_fut(i-1)(1,nages-1),s_Sv_future(i-1)(1,nages-1));
        a_natagev_fut(i)(2,nages)   =++elem_prod(a_natagev_fut(i-1)(1,nages-1),a_Sv_future(i-1)(1,nages-1));
        s_natagev_fut(i,1)          =s_natage_future(i,1);
        a_natagev_fut(i,1)          =a_natage_future(i,1);				
				/*
			    if(SrType==1)
			    {
					natage_future(i,1)=((ssbiom_future(i-1)/(alpha + beta*ssbiom_future(i-1))))*new_ind(i);
			    }
			    else
			    {  
					natage_future(i,1)=(alpha*ssbiom_future(i-1)*mfexp(-beta*ssbiom_future(i-1)))*new_ind(i);
			    }
				*/
				//Guarda la proporcion de reclutamiento de sardina del Modelo Operativo
				prop_srecl_mop_future(l,i)=new_prop(i);
				//Guarda la proporcion teorica de captura
				prop_scatch_mop_future(l,i)=2.5*new_prop(i)-4.5*square(new_prop(i))+3*pow(new_prop(i),3);
        s_expl_biom(i) =0.;
        a_expl_biom(i) =0.;
        expl_biom(i)   =0.;
				for(j=1;j<=nages;j++)
				{
          s_expl_biom(i) +=s_sel_f(endyr,j)*s_wt(j)*s_natage_future(i,j);
          a_expl_biom(i) +=a_sel_f(endyr,j)*a_wt(j)*a_natage_future(i,j);
          expl_biom(i)   +=a_expl_biom(i)+s_expl_biom(i);
				}
				//Simulacion de nuevos datos considerando la Mortalidad por Pesca generada por la captura
				s_biomass_future(i)=0.;
				a_biomass_future(i)=0.;
				s_sim_HB(i)=0.;		
				a_sim_HB(i)=0.;
				s_ssbv_future(i)=0.;
				a_ssbv_future(i)=0.;
				for(j=1;j<=nages;j++)
				{
          s_sim_p_recage(i,j) =s_sel_reclas(j)*s_natage_future(i,j); //Solucion exacta
          a_sim_p_recage(i,j) =a_sel_reclas(j)*a_natage_future(i,j); //Solucion exacta
          s_biomass_future(i) +=s_wt(j)*s_natage_future(i,j);  //biomasa
          a_biomass_future(i) +=a_wt(j)*a_natage_future(i,j);  //biomasa
          s_sim_HB(i)         +=s_sel_reclas(j)*s_wt(j)*s_natage_future(i,j)*s_reclas_epsilon(i);
          a_sim_HB(i)         +=a_sel_reclas(j)*a_wt(j)*a_natage_future(i,j)*a_reclas_epsilon(i);
          s_ssbv_future(i)    +=s_natagev_fut(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_natmort);
          a_ssbv_future(i)    +=a_natagev_fut(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_natmort);
				}
				s_freq.initialize();
				a_freq.initialize();
				ivector s_bin(1,100);
				ivector a_bin(1,100);
        s_sim_p_recage(i) =s_sim_p_recage(i)/sum(s_sim_p_recage(i));
        a_sim_p_recage(i) =a_sim_p_recage(i)/sum(a_sim_p_recage(i));
        s_sim_p_reclen(i) =s_sim_p_recage(i)*s_alk;
        a_sim_p_reclen(i) =a_sim_p_recage(i)*a_alk;
        s_p               = value(s_sim_p_reclen(i));
        a_p               = value(a_sim_p_reclen(i));
        s_p               /=sum(s_p);
        a_p               /=sum(a_p);
        s_bin.fill_multinomial(rng,s_p);
        a_bin.fill_multinomial(rng,a_p);
        for(j             =1;j<=100;j++){s_freq(s_bin(j))++;a_freq(a_bin(j))++;}
        s_p               = s_freq/sum(s_freq);
        a_p               = a_freq/sum(a_freq);
        s_sim_p_reclen(i) =s_p; //Composicion por tallas reclas
        a_sim_p_reclen(i) =a_p;				
				if(catch_future(l,i)!=0)
				{
					//Sardina 
          dvariable s_ffpen =0.0;
          dvariable s_SK    =posfun((s_expl_biom(i)-s_catch_future(l,i))/s_expl_biom(i),0.05,s_ffpen);
          s_Kobs_tot_catch  =s_expl_biom(i)-s_SK*s_expl_biom(i);
          do_Newton_Raphson_for_mortality1(i);					
          //Anchoveta
          dvariable a_ffpen =0.0;
          dvariable a_SK    =posfun((a_expl_biom(i)-a_catch_future(l,i))/a_expl_biom(i),0.05,a_ffpen);
          a_Kobs_tot_catch  =a_expl_biom(i)-a_SK*a_expl_biom(i);
          do_Newton_Raphson_for_mortality2(i);
          //Efecto total					
          dvariable ffpen   =0.0;
          dvariable SK      =posfun((expl_biom(i)-catch_future(l,i))/expl_biom(i),0.05,ffpen);
          Kobs_tot_catch    =expl_biom(i)-SK*expl_biom(i);
          do_Newton_Raphson_for_mortality(i);					
				}
				else
				{
					s_F_future(i)=0.;
					a_F_future(i)=0.;
					F_future(i)=0.;
				}				
        s_Z_future(i)         =s_F_future(i)+s_natmort;
        s_S_future(i)         =exp(-1.*s_Z_future(i));
        s_Fyr_future(l,i)     =max(s_F_future(i));
        a_Z_future(i)         =a_F_future(i)+a_natmort;
        a_S_future(i)         =exp(-1.*a_Z_future(i));
        a_Fyr_future(l,i)     =max(a_F_future(i));
        Z_future(i)           =F_future(i)+natmort;
        S_future(i)           =exp(-1.*Z_future(i));
        Fyr_future(l,i)       =max(F_future(i));				
        s_Sv_future(i)        =mfexp(-1.*s_natmort);
        a_Sv_future(i)        =mfexp(-1.*a_natmort);
        future_biomass(l,i)   =0;
        future_ssbiom(l,i)    =0;
        s_future_biomass(l,i) =0;
        s_future_ssbiom(l,i)  =0;
        a_future_biomass(l,i) =0;
        a_future_ssbiom(l,i)  =0;
				for(j=1;j<=nages;j++)
				{
          s_future_biomass(l,i) +=s_wt(j)*s_natage_future(i,j);
          s_future_ssbiom(l,i)  +=s_natage_future(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_Z_future(i,j));
          a_future_biomass(l,i) +=a_wt(j)*a_natage_future(i,j);
          a_future_ssbiom(l,i)  +=a_natage_future(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_Z_future(i,j));
          future_biomass(l,i)   +=s_future_biomass(l,i)+a_future_biomass(l,i);
          future_ssbiom(l,i)    +=s_future_ssbiom(l,i)+a_future_ssbiom(l,i);
				}
				s_ssb1_ratio(l,i)=s_future_ssbiom(l,i)/s_ssb(endyr);
				s_ssb2_ratio(l,i)=s_future_ssbiom(l,i)/s_avgssb;
				s_ssb3_ratio(l,i)=s_future_ssbiom(l,i)/s_S0;
				a_ssb1_ratio(l,i)=a_future_ssbiom(l,i)/a_ssb(endyr);
				a_ssb2_ratio(l,i)=a_future_ssbiom(l,i)/a_avgssb;
				a_ssb3_ratio(l,i)=a_future_ssbiom(l,i)/a_S0;
				ssb1_ratio(l,i)=future_ssbiom(l,i)/ssb(endyr);
				ssb2_ratio(l,i)=future_ssbiom(l,i)/avgssb;
				ssb3_ratio(l,i)=future_ssbiom(l,i)/(s_S0+a_S0);				
				s_rprp(l,i)=s_future_ssbiom(l,i)/s_ssbv_future(i);
				a_rprp(l,i)=a_future_ssbiom(l,i)/a_ssbv_future(i);
				rprp(l,i)=future_ssbiom(l,i)/(s_ssbv_future(i)+a_ssbv_future(i));
				//Recalcula los indices faltantes despues de la mortalidad por pesca generada por la CTP
				s_ssbiom_future(i)=0.;
				a_ssbiom_future(i)=0.;
				ssbiom_future(i)=0.;
				s_sim_HB2(i)=0.;
				a_sim_HB2(i)=0.;
				for(j=1;j<=nages;j++)
				{
					s_sim_p_fishage(i,j)=s_F_future(i,j)*s_natage_future(i,j)*(1-exp(-1.*s_Z_future(i,j)))/s_Z_future(i,j);
					a_sim_p_fishage(i,j)=a_F_future(i,j)*a_natage_future(i,j)*(1-exp(-1.*a_Z_future(i,j)))/a_Z_future(i,j);
					s_sim_p_pelage(i,j)=s_sel_pelaces(j)*s_natage_future(i,j)*mfexp(-0.375*s_Z_future(i,j));
					a_sim_p_pelage(i,j)=a_sel_pelaces(j)*a_natage_future(i,j)*mfexp(-0.375*a_Z_future(i,j));
					s_ssbiom_future(i)+=s_natage_future(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_Z_future(i,j));
					a_ssbiom_future(i)+=a_natage_future(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_Z_future(i,j));
					ssbiom_future(i)+=s_ssbiom_future(i)+a_ssbiom_future(i);
					s_sim_HB2(i)+=s_q_pelaces*s_sel_pelaces(j)*s_wt(j)*s_natage_future(i,j)*mfexp(-0.375*s_Z_future(i,j))*s_pelaces_epsilon(i);
					a_sim_HB2(i)+=a_q_pelaces*a_sel_pelaces(j)*a_wt(j)*a_natage_future(i,j)*mfexp(-0.375*a_Z_future(i,j))*a_pelaces_epsilon(i);
				}
				s_freq.initialize();
				a_freq.initialize();
				//ivector bin(1,100);
				s_sim_p_pelage(i)=s_sim_p_pelage(i)/sum(s_sim_p_pelage(i));
				s_sim_p_pellen(i)=s_sim_p_pelage(i)*s_alk;
				a_sim_p_pelage(i)=a_sim_p_pelage(i)/sum(a_sim_p_pelage(i));
				a_sim_p_pellen(i)=a_sim_p_pelage(i)*a_alk;
				//sardina
				s_p = value(s_sim_p_pellen(i));
				s_p /=sum(s_p);
				s_bin.fill_multinomial(rng,s_p);
				for(j=1;j<=100;j++){s_freq(s_bin(j))++;}
				s_p = s_freq/sum(s_freq);
				s_sim_p_pellen(i)=s_p;
				//anchoveta
				a_p = value(a_sim_p_pellen(i));
				a_p /=sum(a_p);
				a_bin.fill_multinomial(rng,a_p);
				for(j=1;j<=100;j++){a_freq(a_bin(j))++;}
				a_p = a_freq/sum(a_freq);
				a_sim_p_pellen(i)=a_p;
				//simula MPH			
				s_sim_MPH(i)=s_q_mph*s_ssbiom_future(i)*s_mph_epsilon(i);
				a_sim_MPH(i)=a_q_mph*a_ssbiom_future(i)*a_mph_epsilon(i);
				//simula CPUE
				s_sim_cpue(i)=s_q_cpue*s_expl_biom(i)*s_cpue_epsilon(i);
				a_sim_cpue(i)=a_q_cpue*a_expl_biom(i)*a_cpue_epsilon(i);
				//catch at length 
				s_freq.initialize();
				a_freq.initialize();
				//ivector bin(1,100);
				s_sim_p_fishage(i)=s_sim_p_fishage(i)/sum(s_sim_p_fishage(i));
				s_sim_p_fishlen(i)=s_sim_p_fishage(i)*s_alk;
				s_p = value(s_sim_p_fishlen(i));
				s_p /=sum(s_p);
				s_bin.fill_multinomial(rng,s_p);
				for(j=1;j<=100;j++){s_freq(s_bin(j))++;}
				s_p = s_freq/sum(s_freq);
				s_sim_p_fishlen(i)=s_p;
				//anchoveta
				a_sim_p_fishage(i)=a_sim_p_fishage(i)/sum(a_sim_p_fishage(i));
				a_sim_p_fishlen(i)=a_sim_p_fishage(i)*a_alk;
				a_p = value(a_sim_p_fishlen(i));
				a_p /=sum(a_p);
				a_bin.fill_multinomial(rng,a_p);
				for(j=1;j<=100;j++){a_freq(a_bin(j))++;}
				a_p = a_freq/sum(a_freq);
				a_sim_p_fishlen(i)=a_p;		
				//Ahora actualiza la evaluacion de sardina
				yrs(i)=i;
				upk = i;
				//numyear = yrs(i)-s_ystr+1;
				sim_num_obs = yrs(i)-styr_fut+1;
				opt=1;
				ofstream ssimdata(s_simname);
				ssimdata << "#Datos simulados para el estimador de sardina-INPESCA"<<endl;
				ssimdata << "#Inicial yr"<<endl;
				ssimdata << s_styr  << endl;
				ssimdata << "#Final yr"<<endl;
				ssimdata << yrs(i)  << endl;
				ssimdata << "#numages"<<endl;
				ssimdata << s_nages <<endl;
				ssimdata << "#Captura anual" <<endl;
				ssimdata << s_catch_bio <<endl; //Los datos historicos 1990-2010
                //agrega la captura next yr
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " " << s_catch_future(l,k) << endl; //Agrega la captura
				}				
				//agrega la cpue no actualizada
				ssimdata << "#Nobs_cpue"<< endl;
				ssimdata << s_nobs_cpue+sim_num_obs << endl;
				ssimdata << "#yrs con datos de cpue"<<endl;
				ssimdata << s_yr_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< yrs(k) << endl; //Agrega y resta un yr
				}				
				ssimdata << "#CPUE"<<endl;
				ssimdata << s_obs_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<<s_sim_cpue(k) << endl; //Agrega y resta un yr
				}
				//agrega la biomasa de reclas
				ssimdata << "#Nobs_survey"<< endl;
				ssimdata << s_nobs_surv+sim_num_obs << endl;
				ssimdata << "#yrs con datos de cpue"<<endl;
				ssimdata << s_yr_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " " <<yrs(k) << endl; //Agrega y resta un yr
				}				
				ssimdata << "#Biomasa acustica reclas"<<endl;
				ssimdata << s_obs_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< s_sim_HB(k) << endl; //Agrega
				}
				//agrega la biomasa de pelaces
				ssimdata << "#Nobs_survey_pelaces"<< endl;
				ssimdata << s_nobs_survpel+sim_num_obs << endl;
				ssimdata << "#yrs con datos de cpue"<<endl;
				ssimdata << s_yr_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< yrs(k) << endl; //Agrega
				}				
				ssimdata << "#Biomasa acustica pelaces"<<endl;
				ssimdata << s_obs_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<<s_sim_HB2(k) << endl; //Agrega
				}
				//agrega los datos de compocisión por tallas
				ssimdata <<"#Num tallas"<<endl;
				ssimdata << s_nlenbins <<endl;
				ssimdata << "#Nobs comp tallas"<<endl;
				ssimdata << s_nobs_fishlen+sim_num_obs <<endl;
				ssimdata << "#yrs con lenfreq"<<endl;
				ssimdata << s_yr_fishlen << endl;
				for(k=styr_fut;k<=upk;k++){
					ssimdata << " "<< yrs(k) << endl; //Agrega
				}
				ssimdata << "#Obs prop talla en la captura:"<<endl;
				ssimdata << s_obs_p_len << endl;
				for(k=styr_fut;k<=upk;k++)
				{
					ssimdata << " " <<s_sim_p_fishlen(k)<<endl;
				}
				ssimdata << "#Opts_proy" << endl;
				ssimdata << opt << endl;
				ssimdata.close();
				//AHORA escribe los datos para anchoveta
				ofstream asimdata(a_simname);
				asimdata << "#Datos simulados para el estimador de sardina-INPESCA"<<endl;
				asimdata << "#Inicial yr"<<endl;
				asimdata << a_styr  << endl;
				asimdata << "#Final yr"<<endl;
				asimdata << yrs(i)  << endl;
				asimdata << "#numages"<<endl;
				asimdata << a_nages <<endl;
				asimdata << "#Captura anual" <<endl;
				asimdata << a_catch_bio <<endl; //Los datos historicos 1990-2010
                //agrega la captura next yr
				for(k=styr_fut;k<=upk;k++){
					asimdata << " "<<a_catch_future(l,k) << endl; //Agrega la captura
				}				
				//agrega la cpue no actualizada
				asimdata << "#Nobs_cpue"<< endl;
				asimdata << a_nobs_cpue+sim_num_obs << endl;
				asimdata << "#yrs con datos de cpue"<<endl;
				asimdata << a_yr_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<yrs(k) << endl; //Agrega y resta un yr
				}				
				asimdata << "#CPUE"<<endl;
				asimdata << a_obs_cpue << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<a_sim_cpue(k) << endl; //Agrega y resta un yr
				}
				//agrega la biomasa de reclas
				asimdata << "#Nobs_survey"<< endl;
				asimdata << a_nobs_surv+sim_num_obs << endl;
				asimdata << "#yrs con datos de cpue"<<endl;
				asimdata << a_yr_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<yrs(k) << endl; //Agrega y resta un yr
				}				
				asimdata << "#Biomasa acustica reclas"<<endl;
				asimdata << a_obs_surv << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<a_sim_HB(k) << endl; //Agrega
				}
				//agrega la biomasa de pelaces
				asimdata << "#Nobs_survey_pelaces"<< endl;
				asimdata << a_nobs_survpel+sim_num_obs << endl;
				asimdata << "#yrs con datos de cpue"<<endl;
				asimdata << a_yr_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<yrs(k) << endl; //Agrega
				}				
				asimdata << "#Biomasa acustica pelaces"<<endl;
				asimdata << a_obs_survpel << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " " <<a_sim_HB2(k) << endl; //Agrega
				}
				//agrega los datos de compocisión por tallas
				asimdata <<"#Num tallas"<<endl;
				asimdata << a_nlenbins <<endl;
				asimdata << "#Nobs comp tallas"<<endl;
				asimdata << a_nobs_fishlen+sim_num_obs <<endl;
				asimdata << "#yrs con lenfreq"<<endl;
				asimdata << a_yr_fishlen << endl;
				for(k=styr_fut;k<=upk;k++){
					asimdata << " "<<yrs(k) << endl; //Agrega
				}
				asimdata << "#Obs prop talla en la captura:"<<endl;
				asimdata << a_obs_p_len << endl;
				for(k=styr_fut;k<=upk;k++)
				{
					asimdata << " " <<a_sim_p_fishlen(k)<<endl;
				}
				asimdata << "#Opts_proy" << endl;
				asimdata << opt << endl;
				asimdata.close();
				//ahora corre el estimador para dejar preparada la con styr_fut
				rv=system("sardina -nox -nohess -iprint 200");
				rv=system("anchoveta -nox -nohess -iprint 200");								
			}
		}
	}
	//SaveOM1 << prop_ini_scatch_est_future << endl;
	//SaveOM1.close();
	SaveOM2 << prop_fin_scatch_est_future << endl;
	SaveOM2.close();
	SaveOM3 << prop_scatch_mop_future << endl;
	SaveOM3.close();
	rep1 << s_Fyr_future <<endl;
	rep2 << a_Fyr_future <<endl;
	rep3 << s_catch_future <<endl;
	rep4 << a_catch_future <<endl;
	rep5 << s_future_ssbiom << endl;
	rep6 << a_future_ssbiom << endl;
	rep7 << s_future_biomass << endl;
	rep8 << a_future_biomass << endl;
	reprat1 << s_ssb1_ratio  <<endl;
	reprat2 << a_ssb1_ratio  <<endl;
	reprat3 << s_ssb2_ratio  <<endl;
	reprat4 << a_ssb2_ratio  <<endl;
	reprat5 << s_ssb3_ratio  <<endl;
	reprat6 << a_ssb3_ratio  <<endl;
	reprat7 << s_rprp  <<endl;
	reprat8 << a_rprp  <<endl;
}

void model_parameters::get_selectivity(void)
{
  random_number_generator& rng= *pad_rng;
  //==+==+==+==+Selectividad Pesq Sardina
  s_avgsel_fish=log(mean(exp(s_log_selcoffs_f)));
  for(j=1;j<=s_nselagef;j++)
    {
     s_log_sel_f(styr,j)=s_log_selcoffs_f(j);
    }
  for (j=s_nselagef+1;j<=nages;j++)
    {
     s_log_sel_f(styr,j)=s_log_sel_f(styr,j-1);
    }
  s_log_sel_f(styr)-=log(mean(exp(s_log_sel_f(styr))));
  //==+==+==+==+Selectividad Pesq Anchoveta
  a_avgsel_fish=log(mean(exp(a_log_selcoffs_f)));
  for (j=1;j<=a_nselagef;j++)
    {
     a_log_sel_f(styr,j)=a_log_selcoffs_f(j);
    }
  for (j=a_nselagef+1;j<=nages;j++)
    {
     a_log_sel_f(styr,j)=a_log_sel_f(styr,j-1);
    }
  a_log_sel_f(styr)-=log(mean(exp(a_log_sel_f(styr))));
  //==+==+==+==+==+==+==+==+Selectividad Sardina==+==+==+==+==+==+==+==+==+==+==+==+
  int ii;
  if(active(s_sel_devs_f))
  {
   ii=1;
   for (i=styr;i<endyr;i++)
    {
     if (!(i%s_group_num_f))
     {
      for (j=1;j<=s_nselagef;j++)
       {
        s_log_sel_f(i+1,j)=s_log_sel_f(i,j)+s_sel_devs_f(ii,j);
       }
      for (j=s_nselagef+1;j<=nages;j++)
       {
        s_log_sel_f(i+1,j)=s_log_sel_f(i+1,j-1);
       }
      ii++;
      s_log_sel_f(i+1)-=log(mean(mfexp(s_log_sel_f(i+1))));
     }
     else
     {
      for (j=1;j<=s_nselagef;j++)
       {
        s_log_sel_f(i+1,j)=s_log_sel_f(i,j);
       }
      for (j=s_nselagef+1;j<=nages;j++)
       {
        s_log_sel_f(i+1,j)=s_log_sel_f(i+1,j-1);
       }
      s_log_sel_f(i+1)-=log(mean(mfexp(s_log_sel_f(i+1))));
     }
    }
  }
  else
  {
   for (i=styr;i<endyr;i++)
   {
      for (j=1;j<=s_nselagef;j++)
      {
        s_log_sel_f(i+1,j)=s_log_sel_f(i,j);
      }
      for (j=s_nselagef+1;j<=nages;j++)
      {
        s_log_sel_f(i+1,j)=s_log_sel_f(i+1,j-1);
      }
    }
  }
  s_sel_f=mfexp(s_log_sel_f);
  for (i=styr;i<=endyr;i++)
    {
     s_sel_f(i)=s_sel_f(i)/max(s_sel_f(i));
    }
  //==+==+====+==+==+==+Selectividad Anchoveta==+==+==+==+==+==++
  if(active(a_sel_devs_f))
  {
   ii=1;
   for (i=styr;i<endyr;i++) 
    {
     if (!(i%a_group_num_f))
     {
      for (j=1;j<=a_nselagef;j++)
       {
        a_log_sel_f(i+1,j)=a_log_sel_f(i,j)+a_sel_devs_f(ii,j);
       }
      for (j=a_nselagef+1;j<=nages;j++)
       {
        a_log_sel_f(i+1,j)=a_log_sel_f(i+1,j-1);
       }
      ii++;
      a_log_sel_f(i+1)-=log(mean(mfexp(a_log_sel_f(i+1))));
     }
     else
     {
      for (j=1;j<=a_nselagef;j++)
       {
        a_log_sel_f(i+1,j)=a_log_sel_f(i,j);
       }
      for (int j=a_nselagef+1;j<=nages;j++)
       {
        a_log_sel_f(i+1,j)=a_log_sel_f(i+1,j-1);
       }
      a_log_sel_f(i+1)-=log(mean(mfexp(a_log_sel_f(i+1))));
     }
    }
  }
  else
  {
   for (i=styr;i<endyr;i++) 
   {
      for (j=1;j<=a_nselagef;j++)
      {
        a_log_sel_f(i+1,j)=a_log_sel_f(i,j);
      }
      for (j=a_nselagef+1;j<=nages;j++)
      {
        a_log_sel_f(i+1,j)=a_log_sel_f(i+1,j-1);
      }
    }
  }
  a_sel_f=mfexp(a_log_sel_f);
  for (i=styr;i<=endyr;i++)
    {
     a_sel_f(i)=a_sel_f(i)/max(a_sel_f(i));
    }
  //cout << "a_sel_f " << a_sel_f << endl;
 //==+==+==+==+==+==+==+Selectividad Crucero +==+==+==+==+==+==+==+==+==+==+
 //RECLAS SARDINA====
  s_avgsel_reclas=log(mean(exp(s_log_selcoffs_reclas)));
  for (j=1;j<=s_nselagesurv;j++)
  {
   s_log_sel_reclas(j)=s_log_selcoffs_reclas(j);
    }
  for (j=s_nselagesurv+1;j<=nages;j++)
   {
   s_log_sel_reclas(j)=s_log_sel_reclas(j-1);
    }
  s_log_sel_reclas-=log(mean(exp(s_log_sel_reclas)));
  s_sel_reclas=mfexp(s_log_sel_reclas);
  s_sel_reclas=s_sel_reclas/max(s_sel_reclas);
 //====RECLAS ANCHOVETA====
  a_avgsel_reclas=log(mean(exp(a_log_selcoffs_reclas)));
  for (j=1;j<=a_nselagesurv;j++)
  {
   a_log_sel_reclas(j)=a_log_selcoffs_reclas(j);
    }
  for (j=a_nselagesurv+1;j<=nages;j++)
   {
   a_log_sel_reclas(j)=a_log_sel_reclas(j-1);
    }
  a_log_sel_reclas-=log(mean(exp(a_log_sel_reclas)));
  a_sel_reclas=mfexp(a_log_sel_reclas);
  a_sel_reclas=a_sel_reclas/max(a_sel_reclas);
 //PELACES SARDINA
  s_avgsel_pelaces=log(mean(exp(s_log_selcoffs_pelaces)));
  for (j=1;j<=s_nselagesurv;j++)
  {
    s_log_sel_pelaces(j)=s_log_selcoffs_pelaces(j);
   }
  for (j=s_nselagesurv+1;j<=nages;j++)
   {
   s_log_sel_pelaces(j)=s_log_sel_pelaces(j-1);
    }
  s_log_sel_pelaces-=log(mean(exp(s_log_sel_pelaces)));
  s_sel_pelaces=mfexp(s_log_sel_pelaces);
  s_sel_pelaces=s_sel_pelaces/max(s_sel_pelaces);
 //PELACES ANCHOVETA
  a_avgsel_pelaces=log(mean(exp(a_log_selcoffs_pelaces)));
  for (j=1;j<=a_nselagesurv;j++)
  {
    a_log_sel_pelaces(j)=a_log_selcoffs_pelaces(j);
   }
  for (j=a_nselagesurv+1;j<=nages;j++)
   {
     a_log_sel_pelaces(j)=a_log_sel_pelaces(j-1);
    }
  a_log_sel_pelaces-=log(mean(exp(a_log_sel_pelaces)));
  a_sel_pelaces=mfexp(a_log_sel_pelaces);
  a_sel_pelaces=a_sel_pelaces/max(a_sel_pelaces);
}

void model_parameters::get_mortality(void)
{
  random_number_generator& rng= *pad_rng;
  s_Fmort=mfexp(s_log_avg_fmort+s_fmort_dev);
  a_Fmort=mfexp(a_log_avg_fmort+a_fmort_dev);
  for (i=styr;i<=endyr;i++)
  {
     for (j=1;j<=nages;j++)
     {
      s_F(i,j)=s_Fmort(i)*s_sel_f(i,j);
      a_F(i,j)=a_Fmort(i)*a_sel_f(i,j);
     }
  }
  s_Z=s_F+s_natmort;
  a_Z=a_F+a_natmort;
  s_S=mfexp(-1.*s_Z);
  a_S=mfexp(-1.*a_Z);
  s_Sv=mfexp(-1.*s_natmort);
  a_Sv=mfexp(-1.*a_natmort);
  //cout << a_Fmort << endl;
 //==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+
}

void model_parameters::get_numbers_at_age(void)
{
  random_number_generator& rng= *pad_rng;
  //cout << "log_R "<<log_R<<endl;
  //cout << "rec_dev "<<rec_dev<<endl;
  //Abundancia inicial
  //int itmp;
  for (j=1;j<nages;j++)
  {
   //itmp=styr+1-j;
   //natage(styr,j) = mfexp(log_R - natmort*double(j-1)+rec_dev(itmp));
   //s_natage(styr,j)= natage(styr,j)*prop(styr);
   //a_natage(styr,j)= natage(styr,j)*(1.-prop(styr));
	  s_natage(styr,j)=prop(styr)*mfexp(log_R)*mfexp(-s_natmort*double(j-1)+s_rec_dev_ini(j)-0.5*square(sigr_ini));
	  a_natage(styr,j)=(1-prop(styr))*mfexp(log_R)*mfexp(-a_natmort*double(j-1)+a_rec_dev_ini(j)-0.5*square(sigr_ini));
	  natage(styr,j)=s_natage(styr,j)+a_natage(styr,j);
  }
  //itmp=styr+1-nages;
  //natage(styr,nages)= mfexp(log_R+rec_dev(itmp)-natmort*(nages-1)); //(1.-exp(-natmort));
  //s_natage(styr,nages)= natage(styr,nages)*prop(styr);
  //a_natage(styr,nages)= natage(styr,nages)*(1.-prop(styr));
  s_natage(styr,nages)=prop(styr)*mfexp(log_R)*mfexp(-s_natmort*(nages-1)+s_rec_dev_ini(nages)-0.5*square(sigr_ini));
  a_natage(styr,nages)=(1-prop(styr))*mfexp(log_R)*mfexp(-a_natmort*(nages-1)+a_rec_dev_ini(nages)-0.5*square(sigr_ini));
  natage(styr,nages)=s_natage(styr,nages)+a_natage(styr,nages);
  //Now for different years
  for (i=styr+1;i<=endyr;i++)
    {
     s_natage(i,1)=prop(i)*mfexp(log_R+rec_dev(i)-0.5*square(sigr));
     a_natage(i,1)=(1.-prop(i))*mfexp(log_R+rec_dev(i)-0.5*square(sigr));
	 natage(i,1)=s_natage(i,1)+a_natage(i,1);
     for (j=1;j<nages;j++)
       {  
        s_natage(i,j+1)=s_natage(i-1,j)*s_S(i-1,j);
        a_natage(i,j+1)=a_natage(i-1,j)*a_S(i-1,j);
       }
       //s_natage(i,nages)+=s_natage(i,nages)*s_S(i,nages);
       //a_natage(i,nages)+=a_natage(i,nages)*a_S(i,nages);
       natage(i)=s_natage(i)+a_natage(i);
    }
  for (i=styr;i<=endyr;i++)
    {
     s_biomad(i)=0.;
     a_biomad(i)=0.;
     s_ssb(i)=0.;
     a_ssb(i)=0.;
     for (j=1;j<=nages;j++)
       {
        s_biomad(i)+=s_natage(i,j)*s_wt(j)*s_mat(j);
        s_ssb(i)+=s_natage(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_Z(i,j));
        a_biomad(i)+=a_natage(i,j)*a_wt(j)*a_mat(j);
        a_ssb(i)+=a_natage(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_Z(i,j));
       }
    }
  s_natsize=s_natage*s_alk;
  a_natsize=a_natage*a_alk;
  natsize = s_natsize+a_natsize;
  for (i=styr;i<=endyr;i++)
  {
   recruits(i)=natage(i,1);
   s_biom(i)=0.;
   a_biom(i)=0.;
   for (j=1;j<=nages;j++)
    {
     s_biom(i)+=s_natage(i,j)*s_wt(j);
     a_biom(i)+=a_natage(i,j)*a_wt(j);
    }
  }
   biomass=s_biom+a_biom;
   ssb=s_ssb+a_ssb;
   endbiom=biomass(endyr);
   s_endbio=s_ssb(endyr);
   a_endbio=a_ssb(endyr);
  //cout << "biomass " << biomass << endl;
  //cout << "s_biom " << s_biom << endl;
  //cout << "a_biom " << a_biom << endl;
  //==+==+==+==SELECTIVIDAD TOTAL BASADA EN F ponderado
  for (i=styr;i<=endyr;i++)
    {
     for (j=1;j<=nages;j++)
       {
        Ft(i,j)=(s_F(i,j)*s_natage(i,j)+a_F(i,j)*a_natage(i,j))/natage(i,j);
       }
     sel_fish(i)=Ft(i)/max(Ft(i));
    }  
   //cout << "sel_fish "<< sel_fish << endl;
   for (i=styr;i<endyr;i++)
     {
      for (j=1;j<nages;j++)
        {
         S(i,j)=natage(i,j)/natage(i+1,j+1);
		 Z(i,j)=log(S(i,j));
        }
     }  
  //==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+
}

void model_parameters::get_catch_at_age(void)
{
  random_number_generator& rng= *pad_rng;
  for (int i=styr;i<=endyr;i++)
   {
    s_pred_catch(i)=0.;
    a_pred_catch(i)=0.;
    //Baranov equation
    for (j=1;j<=nages;j++)
    {
     s_catage(i,j)=s_natage(i,j)*s_F(i,j)*(1.-s_S(i,j))/s_Z(i,j);
     a_catage(i,j)=a_natage(i,j)*a_F(i,j)*(1.-a_S(i,j))/a_Z(i,j);
     catage(i,j)=s_catage(i,j)+a_catage(i,j);
     s_pred_catch(i)+=s_catage(i,j)*s_wt(j);
     a_pred_catch(i)+=a_catage(i,j)*a_wt(j);
    }
   pred_catch(i)=s_pred_catch(i)+a_pred_catch(i);
   }
   //cout << "pred_catch"<<pred_catch << endl;
}

void model_parameters::get_predicted_values(void)
{
  random_number_generator& rng= *pad_rng;
  int ii;
  s_q_reclas=mfexp(s_log_q_reclas);
  a_q_reclas=mfexp(a_log_q_reclas);
  //q_reclas=mfexp(log_q_reclas);
  //q_reclas=
  s_q_pelaces=mfexp(s_log_q_pelaces);
  a_q_pelaces=mfexp(a_log_q_pelaces);
  //q_pelaces=mfexp(log_q_pelaces);
  s_q_mph=mfexp(s_log_q_mph);
  a_q_mph=mfexp(a_log_q_mph);
  //cout << "qs "<< q_reclas << q_pelaces << q_mph << endl;
  for (i=1;i<=nobs_reclas;i++)
  {
   ii                   =yrs_reclas(i);
   s_pred_reclas(i)     =0.;
   s_pred_num_reclas(i) =0.;
   a_pred_reclas(i)     =0.;
   a_pred_num_reclas(i) =0.;
   t_pred_reclas(i)     =0.;
   for (j=1;j<=nages;j++)
   {
      s_pred_num_reclas(i) +=s_sel_reclas(j)*s_natage(ii,j);
      a_pred_num_reclas(i) +=a_sel_reclas(j)*a_natage(ii,j);
      s_pred_reclas(i)     +=s_q_reclas*(s_sel_reclas(j)*s_natage(ii,j)*s_wt(j));
      a_pred_reclas(i)     +=a_q_reclas*(a_sel_reclas(j)*a_natage(ii,j)*a_wt(j));
      //s_pred_reclas(i)   +=q_reclas*(s_sel_reclas(j)*s_natage(ii,j)*s_wt(j));
      //a_pred_reclas(i)   +=q_reclas*(a_sel_reclas(j)*a_natage(ii,j)*a_wt(i));
    }
	  t_pred_reclas(i)=(s_pred_reclas(i)+a_pred_reclas(i));	
  }
  //PELACES
  for (i=1;i<=nobs_pel;i++)
  {
    ii                    =yrs_pel(i);
    s_pred_pelaces(i)     =0.;
    s_pred_num_pelaces(i) =0.;
    a_pred_pelaces(i)     =0.;
    a_pred_num_pelaces(i) =0.;
    t_pred_pelaces(i)     =0.;
    for (j=1;j<=nages;j++)
    {
      s_pred_num_pelaces(i) +=s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j));
      a_pred_num_pelaces(i) +=a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j));
      s_pred_pelaces(i)     +=s_q_pelaces*(s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j))*s_wt(j));
      a_pred_pelaces(i)     +=a_q_pelaces*(a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j))*a_wt(j));
      //s_pred_pelaces(i)   +=q_pelaces*(s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j))*s_wt(j));
      //a_pred_pelaces(i)   +=q_pelaces*(a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j))*a_wt(j));		
    }
 	  t_pred_pelaces(i)=(s_pred_pelaces(i)+a_pred_pelaces(i));
  }
  //ACA VOY
  //MPH
  for (i=1;i<=nobs_mph;i++)
  {
   ii=yrs_mph(i);
   s_pred_mph(i)=0.;
   a_pred_mph(i)=0.;
   t_pred_mph(i)=0.;
   for (j=1;j<=nages;j++)
    {
     	s_pred_mph(i)+=s_q_mph*s_wt(j)*s_mat(j)*s_natage(ii,j)*mfexp(-0.583*s_Z(ii,j));
     	a_pred_mph(i)+=a_q_mph*a_wt(j)*a_mat(j)*a_natage(ii,j)*mfexp(-0.583*a_Z(ii,j));
    }
   	t_pred_mph(i)=(s_pred_mph(i)+a_pred_mph(i));
  }
  //cout << "t_pred_reclas " << t_pred_reclas << endl;
  //==+==+==+==Estimated age composition Pesqueria+==+==+==
  for (i=1;i<=s_nobs_lfdfish;i++)
  {
    ii=s_yrs_lfdfish(i);
    s_pred_p_age_fish(i)=s_catage(ii)/sum(s_catage(ii));
  }
  for (i=1;i<=s_nobs_lfdfish;i++)
  {
    s_pred_p_len_fish(i)=s_pred_p_age_fish(i)*s_alk;
  }
  for (i=1;i<=a_nobs_lfdfish;i++)
  {
    ii=a_yrs_lfdfish(i);
    a_pred_p_age_fish(i)=a_catage(ii)/sum(a_catage(ii));
  }
  for (i=1;i<=a_nobs_lfdfish;i++)
  {
    a_pred_p_len_fish(i)=a_pred_p_age_fish(i)*a_alk;
  }
  //cout << "a_pred_p_len_fish "<< a_pred_p_len_fish<< endl; 
  //==+==+== Compo por talla crucero
  //RECLAS
     for (i=1;i<=s_nobs_lfdrec;i++)
      {
      ii=s_yrs_lfdrec(i);
      for (j=1;j<=nages;j++)
        {
         s_pred_p_age_rec(i,j)=s_sel_reclas(j)*s_natage(ii,j)/s_pred_num_reclas(i);
        }
       s_pred_p_len_rec(i)=s_pred_p_age_rec(i)*s_alk;
      }
     for (i=1;i<=a_nobs_lfdrec;i++)
      {
      ii=a_yrs_lfdrec(i);
      for (j=1;j<=nages;j++)
        {
         a_pred_p_age_rec(i,j)=a_sel_reclas(j)*a_natage(ii,j)/a_pred_num_reclas(i);
        }
       a_pred_p_len_rec(i)=a_pred_p_age_rec(i)*a_alk;
      }
  //PELACES
    for (i=1;i<=s_nobs_lfdpel;i++)
      {
      ii=s_yrs_lfdpel(i);
      for (j=1;j<=nages;j++)
        {
         s_pred_p_age_pel(i,j)=s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j))/s_pred_num_pelaces(i);
        }
       s_pred_p_len_pel(i)=s_pred_p_age_pel(i)*s_alk;
      }
  //cout << "s_pred_p_len_pel "<< s_pred_p_len_pel<< endl;
     for (i=1;i<=a_nobs_lfdpel;i++)
      {
      ii=a_yrs_lfdpel(i);
      for (j=1;j<=nages;j++)
        {
         a_pred_p_age_pel(i,j)=a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j))/a_pred_num_pelaces(i);
        }
       a_pred_p_len_pel(i)=a_pred_p_age_pel(i)*a_alk;
      }
  //cout << "a_pred_p_len_pel "<< a_pred_p_len_pel<< endl;
  //==+==+==+===
}

void model_parameters::do_Newton_Raphson_for_mortality1(int i)
{
  random_number_generator& rng= *pad_rng;
  dvariable Fold = s_Kobs_tot_catch/s_expl_biom(i);
  dvariable Fnew ;
  for (int ii=1;ii<=5;ii++)
  {
      dvariable ZZ = Fold + s_natmort;
      dvariable XX = exp(-1.*ZZ);
      dvariable AA = Fold * (1. - XX);
      dvariable BB = ZZ;
      dvariable CC = 1. + (Fold - 1) * XX;
      dvariable dd = 1.;
      dvariable FX = AA / BB - s_Kobs_tot_catch/s_expl_biom(i);
      dvariable FPX = (BB * CC - AA * dd) / (BB * BB);
      Fnew = Fold - FX / FPX;
      Fold = Fnew;
  }
  s_F_future(i)=Fnew*s_sel_f(endyr);
}

void model_parameters::do_Newton_Raphson_for_mortality2(int i)
{
  random_number_generator& rng= *pad_rng;
  dvariable Fold = a_Kobs_tot_catch/a_expl_biom(i);
  dvariable Fnew ;
  for (int ii=1;ii<=5;ii++)
  {
      dvariable ZZ = Fold + a_natmort;
      dvariable XX = exp(-1.*ZZ);
      dvariable AA = Fold * (1. - XX);
      dvariable BB = ZZ;
      dvariable CC = 1. + (Fold - 1) * XX;
      dvariable dd = 1.;
      dvariable FX = AA / BB - a_Kobs_tot_catch/a_expl_biom(i);
      dvariable FPX = (BB * CC - AA * dd) / (BB * BB);
      Fnew = Fold - FX / FPX;
      Fold = Fnew;
  }
  a_F_future(i)=Fnew*a_sel_f(endyr);
}

void model_parameters::do_Newton_Raphson_for_mortality(int i)
{
  random_number_generator& rng= *pad_rng;
   dvariable Fold = Kobs_tot_catch/expl_biom(i);
   dvariable Fnew ;
   for (int ii=1;ii<=5;ii++)
   {
       dvariable ZZ = Fold + natmort;
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
   F_future(i)=Fnew*sel_fish(endyr);
  //+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+==+
}

void model_parameters::evaluate_the_objective_function(void)
{
  random_number_generator& rng= *pad_rng;
	//
	rec_like=norm2(rec_dev)/(2*square(sigr))+size_count(rec_dev)*log(sigr);
    rec_like+=norm2(s_rec_dev_ini)/(2*square(sigr_ini))+size_count(s_rec_dev_ini)*log(sigr_ini);
    rec_like+=norm2(a_rec_dev_ini)/(2*square(sigr_ini))+size_count(a_rec_dev_ini)*log(sigr_ini);
     //if (active(rec_dev_future))
     // {
       //sigmar_fut=norm2(rec_dev)/size_count(rec_dev);
     //  sigmar_fut=sigr;
     //  rec_like+=norm2(rec_dev_future)/(2*square(sigmar_fut))+size_count(rec_dev_future)*log(sigmar_fut);
      //}
  //cout << "rec_like "<< rec_like << endl;
	//*/
     //-Likelihood debida a la composicion por talla
     age_like=0.;
     for (i=1;i<=s_nobs_lfdfish;i++)
      {
       age_like(1)-=s_nfish*s_obs_p_len_fish(i)*log(s_pred_p_len_fish(i)+1e-13);
      }
     age_like(1)-=offset(1);
     for (i=1;i<=a_nobs_lfdfish;i++)
      {
       age_like(2)-=a_nfish*a_obs_p_len_fish(i)*log(a_pred_p_len_fish(i)+1e-13);
      }
     age_like(2)-=offset(2);
    //RECLAS
     for (i=1;i<=s_nobs_lfdrec;i++)
      {
       age_like(3)-=s_nreclas*s_obs_p_len_rec(i)*log(s_pred_p_len_rec(i)+1e-13);
      }
     age_like(3)-=offset(3);
     for (i=1;i<=a_nobs_lfdrec;i++)
      {
       age_like(4)-=a_nreclas*a_obs_p_len_rec(i)*log(a_pred_p_len_rec(i)+1e-13);
      }
      age_like(4)-=offset(4);
     // PELACES
     for (i=1;i<=s_nobs_lfdpel;i++)
      {
       age_like(5)-=s_npelaces*s_obs_p_len_pel(i)*log(s_pred_p_len_pel(i)+1e-13);
      }
      age_like(5)-=offset(5);
     for (i=1;i<=a_nobs_lfdpel;i++)
      {
       age_like(6)-=a_npelaces*a_obs_p_len_pel(i)*log(a_pred_p_len_pel(i)+1e-13);
      }
      age_like(6)-=offset(6);
     //cout << "age_like "<< age_like << endl;
    //surv_like=0.;
    //==+==+==+==+==+==+==Fit to indices
    surv_like(1) =norm2(log(t_obs_reclas+.1)-log(t_pred_reclas+.1))/(2*square(CV_r))+nobs_reclas*log(CV_r);
    surv_like(2) =norm2(log(s_obs_reclas+.1)-log(s_pred_reclas+.1))/(2*square(CV_r)); //+nobs_reclas*log(CV_r);
    surv_like(3) =norm2(log(a_obs_reclas+.1)-log(a_pred_reclas+.1))/(2*square(CV_r)); //+nobs_reclas*log(CV_r);
    surv_like(4) =norm2(log(t_obs_pel+.1)-log(t_pred_pelaces+.1))/(2*square(CV_p))+nobs_pel*log(CV_p);
    surv_like(5) =norm2(log(s_obs_pel+.1)-log(s_pred_pelaces+.1))/(2*square(CV_p)); //+nobs_pel*log(CV_p);
    surv_like(6) =norm2(log(a_obs_pel+.1)-log(a_pred_pelaces+.1))/(2*square(CV_p)); //+nobs_pel*log(CV_p);
    surv_like(7) =norm2(log(t_obs_mph+.1)-log(t_pred_mph+.1))/(2*square(CV_d))+nobs_mph*log(CV_d);
    surv_like(8) =norm2(log(s_obs_mph+.1)-log(s_pred_mph+.1))/(2*square(CV_d)); //+nobs_mph*log(CV_d);
    surv_like(9) =norm2(log(a_obs_mph+.1)-log(a_pred_mph+.1))/(2*square(CV_d)); //+nobs_mph*log(CV_d);
    //cout << "surv_like "<< surv_like << endl;
    ssqcatch(1)  =norm2(log(t_obs_catch+0.1)-log(pred_catch+0.1))/(2*square(CV_y))+size_count(t_obs_catch)*log(CV_y);  //Total catch biomass
    ssqcatch(2)  =norm2(log(s_obs_catch+0.1)-log(s_pred_catch+0.1))/(2*square(CV_y))+size_count(s_obs_catch)*log(CV_y);  //Total catch biomass
    ssqcatch(3)  =norm2(log(a_obs_catch+0.1)-log(a_pred_catch+0.1))/(2*square(CV_y))+size_count(a_obs_catch)*log(CV_y);  //Total catch biomass
       //Selectividad +==+==+==+==+==
   sel_like=0.;
   sel_dev_like=0.;
   for (i=styr;i<=endyr;i++)
     {
      for (j=1;j<nages;j++)
       {
        if (s_log_sel_f(i,j)>s_log_sel_f(i,j+1))
        {
         sel_like(1)+=10*square(s_log_sel_f(i,j)-s_log_sel_f(i,j+1));
        }
       }
     }
   for (i=styr;i<=endyr;i++)
     {
      for (j=1;j<nages;j++)
       {
        if (a_log_sel_f(i,j)>a_log_sel_f(i,j+1))
        {
         sel_like(2)+=10*square(a_log_sel_f(i,j)-a_log_sel_f(i,j+1));
        }
       }
     }
   //SARDINA
   if (active(s_sel_devs_f))
    {
      sel_dev_like(1)+=100/s_group_num_f*norm2(s_sel_devs_f);
      sel_dev_like(1)+=10/s_dim_sel_f*norm2(first_difference(first_difference(s_log_sel_f(styr))));
      for (i=styr;i<endyr;i++)
       {
        if (!(i%s_group_num_f))
         {
          sel_dev_like(1)+=10/s_dim_sel_f*norm2(first_difference(first_difference(s_log_sel_f(i+1))));
         }
       }
    }
    else
    {
      sel_dev_like(1)+=10*norm2(first_difference(first_difference(s_log_sel_f(styr))));
    }
   //ANCHOVETA
   if (active(a_sel_devs_f))
    {
      sel_dev_like(2)+=100/a_group_num_f*norm2(a_sel_devs_f);
      sel_dev_like(2)+=10/a_dim_sel_f*norm2(first_difference(first_difference(a_log_sel_f(styr))));
      for (i=styr;i<endyr;i++)
       {
        if (!(i%a_group_num_f))
         {
          sel_dev_like(2)+=10/a_dim_sel_f*norm2(first_difference(first_difference(a_log_sel_f(i+1))));
         }
       }
    }
    else
    {
      sel_dev_like(2)+=10*norm2(first_difference(first_difference(a_log_sel_f(styr))));
    }
  //=====++++Selectividad Crucero+++++++======
  //====RECLAS SARDINA======
  s_sel_like_reclas=10*norm2(first_difference(first_difference(s_log_sel_reclas)));
  for (j=1;j<nages;j++)
  {
  if(s_log_sel_reclas(j)>s_log_sel_reclas(j+1))
    {
     s_sel_like_reclas+=10*square(s_log_sel_reclas(j)-s_log_sel_reclas(j+1));
    }
   }
  //====RECLAS ANCHOVETA======
  a_sel_like_reclas=10*norm2(first_difference(first_difference(a_log_sel_reclas)));
  for (j=1;j<nages;j++)
  {
  if(a_log_sel_reclas(j)>a_log_sel_reclas(j+1))
    {
     a_sel_like_reclas+=10*square(a_log_sel_reclas(j)-a_log_sel_reclas(j+1));
    }
   }
  //====PELACES SARDINA======
  s_sel_like_pel=10*norm2(first_difference(first_difference(s_log_sel_pelaces)));
  for (j=1;j<nages;j++)
  {
  if(s_log_sel_pelaces(j)>s_log_sel_pelaces(j+1))
    {
     s_sel_like_pel+=10*square(s_log_sel_pelaces(j)-s_log_sel_pelaces(j+1));
    }
   }
  //====PELACES ANCHOVETA======
  a_sel_like_pel=10*norm2(first_difference(first_difference(a_log_sel_pelaces)));
  for (j=1;j<nages;j++)
  {
  if(a_log_sel_pelaces(j)>a_log_sel_pelaces(j+1))
    {
     a_sel_like_pel+=10*square(a_log_sel_pelaces(j)-a_log_sel_pelaces(j+1));
    }
   }
   //prop_like=1.*norm2(prop-0.5);
    //==+==+==Componentes de verosimilitud +==+==+==+==+==
   f+=rec_like;
   f+=sum(ssqcatch);
   f+=sum(age_like);
   f+=sum(surv_like);
   f+=sum(sel_dev_like);
   f+=sum(sel_like);
   f+=s_sel_like_reclas;
   f+=a_sel_like_reclas;
   f+=s_sel_like_pel;
   f+=a_sel_like_pel;
   f+=10.*square(s_avgsel_reclas);
   f+=10.*square(s_avgsel_pelaces);
   f+=10.*square(a_avgsel_reclas);
   f+=10.*square(a_avgsel_pelaces);
   f+=10.*square(s_avgsel_fish);
   f+=10.*square(a_avgsel_fish);
   //Phases less than 3, penalize high F's
   if (current_phase()<3)
     {
     fpen(1)=10.*norm2(mfexp(s_log_avg_fmort+s_fmort_dev)-.2);
     fpen(2)=10.*norm2(mfexp(a_log_avg_fmort+a_fmort_dev)-.2);
     //prop_like=10*norm2(prop-0.5);
     }
   else
     {
     fpen(1)=0.001*norm2(mfexp(s_log_avg_fmort+s_fmort_dev)-.2);
     fpen(2)=0.001*norm2(mfexp(a_log_avg_fmort+a_fmort_dev)-.2);
     //prop_like=0.001*norm2(prop-0.5);
     }
   fpen(1)+=norm2(s_fmort_dev);
   fpen(2)+=norm2(a_fmort_dev);
   f+=prop_like;
   f+=sum(fpen);
}

void model_parameters::write_mcmc_pars(void)
{
  random_number_generator& rng= *pad_rng;
  mcrep(s_log_q_reclas);
  mcrep(a_log_q_reclas);
  mcrep(s_log_q_pelaces);
  mcrep(a_log_q_pelaces);
  mcrep(s_log_q_mph);
  mcrep(a_log_q_mph);
  mcrep(log_R);  
  mcrep(s_rec_dev_ini);
  mcrep(a_rec_dev_ini);
  mcrep(rec_dev);
  mcrep(sigr);
  mcrep(sigr_ini);
  mcrep(prop);
  mcrep(s_log_avg_fmort);
  mcrep(a_log_avg_fmort);
  mcrep(s_fmort_dev);
  mcrep(a_fmort_dev);
  mcrep(s_log_selcoffs_f);
  // mcrep(s_sel_devs_f);
  mcrep(a_log_selcoffs_f);
  // mcrep(a_sel_devs_f);
  mcrep(s_log_selcoffs_reclas);
  mcrep(a_log_selcoffs_reclas);
  mcrep(s_log_selcoffs_pelaces);
  mcrep(a_log_selcoffs_pelaces);
  mcrep(endbiom);
  mcrep(s_endbio);
  mcrep(a_endbio);
  mcrep(recruits);
  mcrep(biomass);  
  mcout<<endl;
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
   //Reporte de resultados
   rep(styr)
   rep(endyr)
   rep(nyr)
   rep(years);
   rep(t_obs_catch)
   rep(pred_catch)
   rep(s_obs_catch)
   rep(s_pred_catch)
   rep(a_obs_catch)
   rep(a_pred_catch)
   rep(yrs_reclas)
   rep(t_obs_reclas)
   rep(t_pred_reclas)
   rep(a_obs_reclas)
   rep(a_pred_reclas)
   rep(s_obs_reclas)
   rep(s_pred_reclas)
   rep(yrs_pel)
   rep(t_obs_pel)
   rep(t_pred_pelaces)
   rep(a_obs_pel)
   rep(a_pred_pelaces)
   rep(s_obs_pel)
   rep(s_pred_pelaces)
   rep(yrs_mph)
   rep(t_obs_mph)
   rep(t_pred_mph)
   rep(s_Fmort)
   rep(a_Fmort)
   rep(biomass)
   rep(ssb)
   rep(s_biom)
   rep(a_biom)
   rep(s_biomad)
   rep(a_biomad)
   rep(s_ssb)
   rep(a_ssb)
   rep(natage)
   rep(s_natage)
   rep(a_natage)
   rep(s_F)
   rep(a_F)
   rep(s_obs_p_len_fish)
   rep(s_pred_p_len_fish)
   rep(a_obs_p_len_fish)
   rep(a_pred_p_len_fish)
   rep(s_obs_p_len_rec)
   rep(s_pred_p_len_rec)
   rep(a_obs_p_len_rec)
   rep(a_pred_p_len_rec)
   rep(s_obs_p_len_pel)
   rep(s_pred_p_len_pel)
   rep(a_obs_p_len_pel)
   rep(a_pred_p_len_pel)
   rep(sel_fish)
   rep(s_sel_f)
   rep(a_sel_f)
   rep(rec_like)
   rep(age_like)
   rep(sel_like)
   rep(sel_dev_like)
   rep(f)
   rep(prop)
   rep(s_alpha)
   rep(s_beta)
   rep(s_S0)
   rep(s_R0)
   rep(a_alpha)
   rep(a_beta)
   rep(a_S0)
   rep(a_R0)
   rep(S0)
}

model_data::~model_data()
{}

model_parameters::~model_parameters()
{
  delete pad_rng;
  pad_rng = NULL;
}

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
	arrmblsize = 5000000;
	gradient_structure::set_GRADSTACK_BUFFER_SIZE(10000000);
	gradient_structure::set_CMPDIF_BUFFER_SIZE(5000000);
	gradient_structure::set_MAX_NVAR_OFFSET(5000);
	gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);
  
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

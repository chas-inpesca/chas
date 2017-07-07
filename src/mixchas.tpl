  //Modelo de evaluacion conjunta para sardina y anchoveta (MIXSAN)
  // MODELO OPERATIVO PARA EVALUAR ESTRATEGIAS DE MANEJO PESQUERIA MIXTA 
  //

DATA_SECTION
	int iseed
	!!long int lseed=iseed;
	!!CLASS random_number_generator rng(iseed);

  init_int debug
  init_int nyr
  init_int styr    //primer año calendario de la evaluacion
  init_int endyr   //ano final
  vector years(styr,endyr)
  !! years.fill_seqadd(styr,1);

  //==== CAPTURAS
  init_vector t_obs_catch(styr,endyr)
  init_vector s_obs_catch(styr,endyr)  //captura sardina
  init_vector a_obs_catch(styr,endyr) //captura anchoveta
  //==+==+== Acustica RECLAS 
  init_int nobs_reclas
  init_ivector yrs_reclas(1,nobs_reclas) //años con datos (p.e. 1991,...,2000)
  init_vector s_obs_reclas(1,nobs_reclas)
  init_vector a_obs_reclas(1,nobs_reclas)
  init_vector t_obs_reclas(1,nobs_reclas)  //Biomasa total acústica
  //==+==+== Acustica PELACES
  init_int nobs_pel
  init_ivector yrs_pel(1,nobs_pel) //años con datos (p.e. 1991,...,2000)
  init_vector s_obs_pel(1,nobs_pel)
  init_vector a_obs_pel(1,nobs_pel)
  init_vector t_obs_pel(1,nobs_pel)  //Biomasa total acústica
  //==+==+== MPH
  init_int nobs_mph
  init_ivector yrs_mph(1,nobs_mph) //años con datos (p.e. 1993,...,2000)
  init_vector s_obs_mph(1,nobs_mph)
  init_vector a_obs_mph(1,nobs_mph)
  init_vector t_obs_mph(1,nobs_mph)  //Biomasa total mph
  //==+==+== Esfuerzo de pesca
  init_int nobs_effort
  init_ivector yrs_effort(1,nobs_effort)
  init_vector obs_effort(1,nobs_effort)
  //==+==+== Length Composition Fishery
  init_int nlen
  init_int s_nobs_lfdfish
  init_ivector s_yrs_lfdfish(1,s_nobs_lfdfish)
  init_matrix s_obs_p_len_fish(1,s_nobs_lfdfish,1,nlen)  
  init_int a_nobs_lfdfish
  init_ivector a_yrs_lfdfish(1,a_nobs_lfdfish)
  init_matrix a_obs_p_len_fish(1,a_nobs_lfdfish,1,nlen)  
  //==+==+== Length Composition Reclas
  init_int s_nobs_lfdrec
  init_ivector s_yrs_lfdrec(1,s_nobs_lfdrec)
  init_matrix s_obs_p_len_rec(1,s_nobs_lfdrec,1,nlen)  
  init_int a_nobs_lfdrec
  init_ivector a_yrs_lfdrec(1,a_nobs_lfdrec)
  init_matrix a_obs_p_len_rec(1,a_nobs_lfdrec,1,nlen)  
  //==+==+== Length Composition Pelaces
  init_int s_nobs_lfdpel
  init_ivector s_yrs_lfdpel(1,s_nobs_lfdpel)
  init_matrix s_obs_p_len_pel(1,s_nobs_lfdpel,1,nlen)  
  init_int a_nobs_lfdpel
  init_ivector a_yrs_lfdpel(1,a_nobs_lfdpel)
  init_matrix a_obs_p_len_pel(1,a_nobs_lfdpel,1,nlen)
  //====End of file
  init_number eof;
  //!!cout<< eof << endl;
  int s_dim_sel_f
  int a_dim_sel_f
  int styr_rec
  int j
  int i
  int l
  //----------
  int phase_F40;
  int endyr_fut;
  int styr_fut;
  int num_str; // Numero de estrategias a evaluar
 LOCAL_CALCS
   styr_rec=styr-nages+1;
   styr_fut=endyr+1;
   endyr_fut=styr_fut+5;
   phase_F40=5;
   num_str=3;
 END_CALCS

  !!ad_comm::change_datafile_name("mixsaninpesca.ctl");
  init_int nages   //numero de grupos de edad
  init_number h //steepness
  init_vector len(1,nlen)
  init_vector s_wt(1,nages)
  init_vector a_wt(1,nages)
  init_vector s_lt(1,nages)
  init_vector a_lt(1,nages)
  init_vector s_mat(1,nages)
  init_vector a_mat(1,nages)
  init_matrix s_alk(1,nages,1,nlen)
  init_matrix a_alk(1,nages,1,nlen)
  //Controladores comp x tallas
  init_int s_nfish   //sardina
  init_int a_nfish   //anchoveta
  init_int s_nreclas   //sardina n muestral para la comp por talla crucero
  init_int a_nreclas   //anchoveta n muestral para la comp por talla crucero
  init_int s_npelaces   //sardina   "         "
  init_int a_npelaces   //anchoveta   "         "
  //Controladores CV indices totales
  //Captura total
  init_number CV_y
  //CV reclas
  init_number CV_r
  //CV pelaces
  init_number CV_p
  //CV mph
  init_number CV_d
  //CV esfuerzo
  init_number CV_e
  //!!cout << "CV_e "<< CV_e <<endl;
  //Otros
  init_int ph_sigmar
  init_int ph_Fdev
  init_int ph_recdev
  init_int s_nselagef     // sardina
  init_int a_nselagef     //  anchoveta
  init_int s_nselagesurv  //  sardina
  init_int a_nselagesurv  //  anchoveta
  init_int s_group_num_f
  init_int a_group_num_f
  init_int s_ph_sel_fish
  init_int a_ph_sel_fish
  init_int s_ph_sel_surv
  init_int a_ph_sel_surv
  init_int s_ph_seldev_f
  init_int a_ph_seldev_f
  init_int ph_rec_q
  init_int ph_pel_q
  init_int ph_q_effort  //no usado en este 
  //init_vector lambda(1,19)

  //!!ad_comm::change_datafile_name("fut_cat.dat");
  //init_matrix MLE_catch(1,5,styr_fut,endyr_fut);
  //!!cout << MLE_catch << endl;


  //===+===+===+===+===+===+===+===+===+===
  //OJO !!!!!!
  //LEE LOS DATOS DE LOS ESTIMADORES (AQUI INSERTAR LA LECTURA DE DATOS HISTORICOS HASTA EL 2010) 
  //!!ad_comm::change_datafile_name("srealdata.dat");
  // copiar la lectura de datos del TPL del estimador
	//******** LEE LOS DATOS REALES DEL ESTIMADOR ******* 
	// SARDINA COMUN
	!!ad_comm::change_datafile_name("sardinareal.dat");
    init_int s_styr  
    init_int s_endyr 
    init_int s_nages  
    init_vector s_catch_bio(s_styr,s_endyr)  //capturas anuales (ton)
    //Datos de CPUE
    init_int s_nobs_cpue
    init_ivector s_yr_cpue(1,s_nobs_cpue)
    init_vector s_obs_cpue(1,s_nobs_cpue)
    //Datos Acustica reclas
    init_int s_nobs_surv
    init_ivector s_yr_surv(1,s_nobs_surv)
    init_vector s_obs_surv(1,s_nobs_surv)
    //Datos Acustica pelaces
    init_int s_nobs_survpel
    init_ivector s_yr_survpel(1,s_nobs_survpel)
    init_vector s_obs_survpel(1,s_nobs_survpel)
    //lee el numero de clases de talla
    init_int s_nlenbins //Clases longitud
    //Lee los datos de composicion por tallas
    init_int s_nobs_fishlen //numero de datos, si se tiene 10 años (=10)
    init_ivector s_yr_fishlen(1,s_nobs_fishlen) //los años para los cual se tiene los datos
    init_matrix s_obs_p_len(1,s_nobs_fishlen,1,s_nlenbins) //la composicion por tallas
    //init_matrix w(styr,endyr,1,nages)
    //init_matrix maturity2(styr,endyr,1,nages)
    //init_matrix M2(styr,endyr,1,nages)
    //init_matrix mt(1,nlenbins,1,nages) 
  
    init_int s_opt_proy;
	//***************************************************
	//******** LEE LOS DATOS REALES DEL ESTIMADOR ******* 
	// ANCHOVETA
	!!ad_comm::change_datafile_name("anchreal.dat");
    init_int a_styr  
    init_int a_endyr 
    init_int a_nages  
    init_vector a_catch_bio(a_styr,a_endyr)  //capturas anuales (ton)
    //Datos de CPUE
    init_int a_nobs_cpue
    init_ivector a_yr_cpue(1,a_nobs_cpue)
    init_vector a_obs_cpue(1,a_nobs_cpue)
    //Datos Acustica reclas
    init_int a_nobs_surv
    init_ivector a_yr_surv(1,a_nobs_surv)
    init_vector a_obs_surv(1,a_nobs_surv)
    //Datos Acustica pelaces
    init_int a_nobs_survpel
    init_ivector a_yr_survpel(1,a_nobs_survpel)
    init_vector a_obs_survpel(1,a_nobs_survpel)
    //lee el numero de clases de talla
    init_int a_nlenbins //Clases longitud
    //Lee los datos de composicion por tallas
    init_int a_nobs_fishlen //numero de datos, si se tiene 10 años (=10)
    init_ivector a_yr_fishlen(1,a_nobs_fishlen) //los años para los cual se tiene los datos
    init_matrix a_obs_p_len(1,a_nobs_fishlen,1,a_nlenbins) //la composicion por tallas
    //init_matrix w(styr,endyr,1,nages)
    //init_matrix maturity2(styr,endyr,1,nages)
    //init_matrix M2(styr,endyr,1,nages)
    //init_matrix mt(1,nlenbins,1,nages) 
  
    init_int a_opt_proy;
	//***************************************************
	//ACTIVA el Modelo Operativo
	int opm;
	!!opm=1;
  //===+===+===+===+===+===+===+===+===+===


 LOCAL_CALCS
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
 END_CALCS
  //!!cout << a_dim_sel_f << endl;

INITIALIZATION_SECTION
  //natmort 0.8;
  s_natmort 1;
  a_natmort 0.7;
  log_R 12;
  sigr 0.8;
  sigr_ini 0.8;
  s_log_avg_fmort -1.;
  a_log_avg_fmort -1.;
  //log_q_reclas -0.001;
  //log_q_pelaces -0.001;
  s_log_q_reclas  -0.001;
  a_log_q_reclas  -0.001;
  s_log_q_pelaces -0.001;
  a_log_q_pelaces -0.001;
  s_log_q_mph -2;
  a_log_q_mph -2;
  prop 0.5;

PARAMETER_SECTION

  //==+==+==catchability para hidroacustica solamente==+==+==
  //init_number log_q_reclas(ph_rec_q)
  //init_number log_q_pelaces(ph_pel_q)
  init_number s_log_q_reclas(ph_rec_q)
  init_number a_log_q_reclas(ph_rec_q)
  init_number s_log_q_pelaces(ph_pel_q)
  init_number a_log_q_pelaces(ph_pel_q)
  init_number s_log_q_mph(ph_pel_q)
  init_number a_log_q_mph(ph_pel_q)

  //==+==+==Mortalidad natural==+==+==
  //init_number natmort(-1)  //Mortalidad natural  ambos
  init_number s_natmort(-1)  //Mortalidad natural  machos
  init_number a_natmort(-1)  //Mortalidad natural  hembras
  number natmort

  //==+==+==+Reclutamientos
  init_number log_R(1);  
  //init_bounded_number log_R(2,16,1);
  //init_vector rec_dev(styr_rec,endyr,ph_recdev)
  init_bounded_dev_vector s_rec_dev_ini(1,nages,-10,10,ph_recdev)
  init_bounded_dev_vector a_rec_dev_ini(1,nages,-10,10,ph_recdev)
	  
  init_bounded_dev_vector rec_dev(styr+1,endyr,-10,10,ph_recdev)
  init_bounded_number sigr(0.01,2,ph_sigmar) //recruitment variance
  init_bounded_number sigr_ini(0.01,2,ph_sigmar)
  init_bounded_vector prop(styr,endyr,0.01,0.99,4)
  //init_bounded_vector prop(styr_rec,endyr,0.01,0.99,1)
  //====== S-R stuff =====
  number s_R0
  number s_S0
  number a_R0
  number a_S0
  number S0
  number s_alpha
  number a_alpha
  number s_beta
  number a_beta
  vector s_neq(1,nages)
  vector a_neq(1,nages)

  //==+==+==fishing mortality
  init_number s_log_avg_fmort(1)
  init_number a_log_avg_fmort(1)
  init_bounded_dev_vector s_fmort_dev(styr,endyr,-5,5,ph_Fdev)
  init_bounded_dev_vector a_fmort_dev(styr,endyr,-5,5,ph_Fdev)

  //selectivity total
  matrix sel_fish(styr,endyr,1,nages)
 
  //selectividad fish sardine
  init_vector s_log_selcoffs_f(1,s_nselagef,s_ph_sel_fish)
  init_bounded_matrix s_sel_devs_f(1,s_dim_sel_f,1,s_nselagef,-5,5,s_ph_seldev_f)
  matrix s_log_sel_f(styr,endyr,1,nages)
  matrix s_sel_f(styr,endyr,1,nages)
  number s_avgsel_fish;

  //selectividad fish anchovy
  init_vector a_log_selcoffs_f(1,a_nselagef,a_ph_sel_fish)
  init_bounded_matrix a_sel_devs_f(1,a_dim_sel_f,1,a_nselagef,-5,5,a_ph_seldev_f)
  matrix a_log_sel_f(styr,endyr,1,nages)
  matrix a_sel_f(styr,endyr,1,nages)
  number a_avgsel_fish;

  //Selectividad Crucero RECLAS sardina 
  init_vector s_log_selcoffs_reclas(1,s_nselagesurv,s_ph_sel_surv)
  vector s_log_sel_reclas(1,nages)
  vector s_sel_reclas(1,nages)
  number s_avgsel_reclas;

  //Selectividad Crucero RECLAS anchoveta
  init_vector a_log_selcoffs_reclas(1,a_nselagesurv,a_ph_sel_surv)
  vector a_log_sel_reclas(1,nages)
  vector a_sel_reclas(1,nages)
  number a_avgsel_reclas;

  //Selectividad Crucero PELACES sardina 
  init_vector s_log_selcoffs_pelaces(1,s_nselagesurv,s_ph_sel_surv)
  vector s_log_sel_pelaces(1,nages)
  vector s_sel_pelaces(1,nages)
  number s_avgsel_pelaces;

  //Selectividad Crucero PELACES anchoveta
  init_vector a_log_selcoffs_pelaces(1,a_nselagesurv,a_ph_sel_surv)
  vector a_log_sel_pelaces(1,nages)
  vector a_sel_pelaces(1,nages)
  number a_avgsel_pelaces;

  //Parametros poblacionales
  matrix natage(styr,endyr,1,nages)
  matrix s_natage(styr,endyr,1,nages)
  matrix a_natage(styr,endyr,1,nages)

  //captura a la edad por yr
  matrix catage(styr,endyr,1,nages)
  matrix s_catage(styr,endyr,1,nages)
  matrix a_catage(styr,endyr,1,nages)

  matrix Z(styr,endyr,1,nages)
  matrix s_Z(styr,endyr,1,nages)
  matrix a_Z(styr,endyr,1,nages)

  matrix Ft(styr,endyr,1,nages)
  matrix s_F(styr,endyr,1,nages)
  matrix a_F(styr,endyr,1,nages)
  matrix S(styr,endyr,1,nages)
  matrix s_S(styr,endyr,1,nages)
  matrix a_S(styr,endyr,1,nages)
  matrix s_Sv(styr,endyr,1,nages)
  matrix a_Sv(styr,endyr,1,nages)

  matrix natsize(styr,endyr,1,nlen)
  matrix s_natsize(styr,endyr,1,nlen)
  matrix a_natsize(styr,endyr,1,nlen)

  vector s_Fmort(styr,endyr)
  vector a_Fmort(styr,endyr)
  vector s_biom(styr,endyr)
  vector a_biom(styr,endyr)
  vector biom(styr,endyr)
  vector s_biomad(styr,endyr) //adultos a comienzos de yr
  vector a_biomad(styr,endyr)
  vector s_ssb(styr,endyr) //a=desovantes en agosto
  vector a_ssb(styr,endyr) //a=desovante en 
  vector ssb(styr,endyr)

  number q_reclas;
  number s_q_reclas;
  number a_q_reclas;
  number q_pelaces;
  number s_q_pelaces;
  number a_q_pelaces;
  number q_mph;
  number s_q_mph;
  number a_q_mph;
 
  number surv  //exp(-M)

  //valores predichos
  vector pred_catch(styr,endyr)
  vector s_pred_catch(styr,endyr)
  vector a_pred_catch(styr,endyr)

  //Cruceros
  //Reclas
  vector s_pred_reclas(1,nobs_reclas)
  vector s_pred_num_reclas(1,nobs_reclas)
  vector a_pred_reclas(1,nobs_reclas)
  vector a_pred_num_reclas(1,nobs_reclas)

  vector t_pred_reclas(1,nobs_reclas)
  //Pelaces
  vector s_pred_pelaces(1,nobs_pel)
  vector s_pred_num_pelaces(1,nobs_pel)
  vector a_pred_pelaces(1,nobs_pel)
  vector a_pred_num_pelaces(1,nobs_pel)
  vector t_pred_pelaces(1,nobs_pel)
  //Mph
  vector s_pred_mph(1,nobs_mph)
  vector s_pred_num_mph(1,nobs_mph)
  vector a_pred_mph(1,nobs_mph)
  vector a_pred_num_mph(1,nobs_mph)
  vector t_pred_mph(1,nobs_mph)
  //Composicion por tallas y edades
  //Pesqueria
  matrix s_pred_p_len_fish(1,s_nobs_lfdfish,1,nlen)
  matrix a_pred_p_len_fish(1,a_nobs_lfdfish,1,nlen)
  matrix s_pred_p_age_fish(1,s_nobs_lfdfish,1,nages)
  matrix a_pred_p_age_fish(1,a_nobs_lfdfish,1,nages)
  //Reclas
  matrix s_pred_p_len_rec(1,s_nobs_lfdrec,1,nlen)
  matrix a_pred_p_len_rec(1,a_nobs_lfdrec,1,nlen)
  matrix s_pred_p_age_rec(1,s_nobs_lfdrec,1,nages)
  matrix a_pred_p_age_rec(1,a_nobs_lfdrec,1,nages)
  //Pelaces
  matrix s_pred_p_len_pel(1,s_nobs_lfdpel,1,nlen)
  matrix a_pred_p_len_pel(1,a_nobs_lfdpel,1,nlen)
  matrix s_pred_p_age_pel(1,s_nobs_lfdpel,1,nages)
  matrix a_pred_p_age_pel(1,a_nobs_lfdpel,1,nages)

  //componentes del ajuste
  vector ssqcatch(1,3);
  number rec_like
  vector fpen(1,2)
  vector surv_like(1,9);
  //vector cvage_like(1,2)
  vector offset(1,6)  
  vector sel_like(1,2)
  vector sel_dev_like(1,2);
  number s_sel_like_reclas;
  number a_sel_like_reclas;
  number s_sel_like_pel;
  number a_sel_like_pel;
  vector age_like(1,6)  
  number prop_like;
  number sigmar
  number sigmar_ini

  //----------------
  //FUTURE PROYECCION
  //number sigmar_fut;
  //number avg_rec_dev_future
  number Kobs_tot_catch;
  number s_Kobs_tot_catch;
  number a_Kobs_tot_catch;
  //init_bounded_vector rec_dev_future(styr_fut,endyr_fut,-5.,5.,7); //una fase mas y ver que sucede  
  matrix natage_future(styr_fut,endyr_fut,1,nages)
  matrix s_natage_future(styr_fut,endyr_fut,1,nages)
  matrix a_natage_future(styr_fut,endyr_fut,1,nages)
  matrix s_natagev_fut(styr_fut,endyr_fut,1,nages)
  matrix a_natagev_fut(styr_fut,endyr_fut,1,nages)
  
  matrix F_future(styr_fut,endyr_fut,1,nages);
  matrix s_F_future(styr_fut,endyr_fut,1,nages);
  matrix a_F_future(styr_fut,endyr_fut,1,nages);
  matrix Z_future(styr_fut,endyr_fut,1,nages);
  matrix s_Z_future(styr_fut,endyr_fut,1,nages);
  matrix a_Z_future(styr_fut,endyr_fut,1,nages);
  matrix S_future(styr_fut,endyr_fut,1,nages);
  matrix s_S_future(styr_fut,endyr_fut,1,nages);
  matrix a_S_future(styr_fut,endyr_fut,1,nages);
  matrix s_Sv_future(styr_fut,endyr_fut,1,nages);
  matrix a_Sv_future(styr_fut,endyr_fut,1,nages);

  matrix catage_future(styr_fut,endyr_fut,1,nages);
  matrix s_catage_future(styr_fut,endyr_fut,1,nages);
  matrix a_catage_future(styr_fut,endyr_fut,1,nages);  

  vector biomass_future(styr_fut,endyr_fut);
  vector s_biomass_future(styr_fut,endyr_fut);
  vector a_biomass_future(styr_fut,endyr_fut);
  vector ssbiom_future(styr_fut,endyr_fut);
  vector s_ssbiom_future(styr_fut,endyr_fut);
  vector a_ssbiom_future(styr_fut,endyr_fut);
  vector s_ssbv_future(styr_fut,endyr_fut);
  vector a_ssbv_future(styr_fut,endyr_fut);
  
  vector expl_biom(styr_fut,endyr_fut);
  vector s_expl_biom(styr_fut,endyr_fut);
  vector a_expl_biom(styr_fut,endyr_fut);

	//===**** DATOS SIMULADOS =====;
	matrix s_sim_p_fishage(styr_fut,endyr_fut,1,nages);
	matrix a_sim_p_fishage(styr_fut,endyr_fut,1,nages);
	matrix s_sim_p_recage(styr_fut,endyr_fut,1,nages);
	matrix a_sim_p_recage(styr_fut,endyr_fut,1,nages);	
	matrix s_sim_p_pelage(styr_fut,endyr_fut,1,nages);
	matrix a_sim_p_pelage(styr_fut,endyr_fut,1,nages);
	
	matrix s_sim_p_fishlen(styr_fut,endyr_fut,1,s_nlenbins);
	matrix a_sim_p_fishlen(styr_fut,endyr_fut,1,s_nlenbins);

	matrix s_sim_p_reclen(styr_fut,endyr_fut,1,s_nlenbins);
	matrix a_sim_p_reclen(styr_fut,endyr_fut,1,s_nlenbins);
	
	matrix s_sim_p_pellen(styr_fut,endyr_fut,1,s_nlenbins);
	matrix a_sim_p_pellen(styr_fut,endyr_fut,1,a_nlenbins);

	vector s_sim_HB(styr_fut,endyr_fut);
	vector a_sim_HB(styr_fut,endyr_fut);

	vector s_sim_HB2(styr_fut,endyr_fut);
	vector a_sim_HB2(styr_fut,endyr_fut);

	vector s_sim_MPH(styr_fut,endyr_fut);
	vector a_sim_MPH(styr_fut,endyr_fut);

	vector s_sim_cpue(styr_fut,endyr_fut);
	vector a_sim_cpue(styr_fut,endyr_fut);

	
	vector new_rec_epsilon(styr_fut,endyr_fut);
	vector new_prop(styr_fut,endyr_fut);

	vector s_reclas_epsilon(styr_fut,endyr_fut);
	vector a_reclas_epsilon(styr_fut,endyr_fut);

	vector s_pelaces_epsilon(styr_fut,endyr_fut);
	vector a_pelaces_epsilon(styr_fut,endyr_fut);
	
	vector s_mph_epsilon(styr_fut,endyr_fut);
	vector a_mph_epsilon(styr_fut,endyr_fut);

	vector s_cpue_epsilon(styr_fut,endyr_fut);
	vector a_cpue_epsilon(styr_fut,endyr_fut);

  
	//Evaluacion
	matrix init_catch_future(1,num_str,styr_fut,endyr_fut);
	matrix s_init_catch_future(1,num_str,styr_fut,endyr_fut);
	matrix a_init_catch_future(1,num_str,styr_fut,endyr_fut);
	matrix catch_future(1,num_str,styr_fut,endyr_fut);
	matrix s_catch_future(1,num_str,styr_fut,endyr_fut);
	matrix a_catch_future(1,num_str,styr_fut,endyr_fut);
	matrix prop_fin_scatch_est_future(1,num_str,styr_fut,endyr_fut);
	matrix prop_ini_scatch_est_future(1,num_str,styr_fut,endyr_fut);
	matrix prop_srecl_mop_future(1,num_str,styr_fut,endyr_fut);
	matrix prop_scatch_mop_future(1,num_str,styr_fut,endyr_fut)
	
	matrix future_biomass(1,num_str,styr_fut,endyr_fut);
	matrix s_future_biomass(1,num_str,styr_fut,endyr_fut);
	matrix a_future_biomass(1,num_str,styr_fut,endyr_fut);
	
	matrix future_ssbiom(1,num_str,styr_fut,endyr_fut);
	matrix s_future_ssbiom(1,num_str,styr_fut,endyr_fut);
	matrix a_future_ssbiom(1,num_str,styr_fut,endyr_fut);
	
	matrix Fyr_future(1,num_str,styr_fut,endyr_fut);
	matrix s_Fyr_future(1,num_str,styr_fut,endyr_fut);
	matrix a_Fyr_future(1,num_str,styr_fut,endyr_fut);
	
	matrix ssb1_ratio(1,num_str,styr_fut,endyr_fut);
	matrix s_ssb1_ratio(1,num_str,styr_fut,endyr_fut);
	matrix a_ssb1_ratio(1,num_str,styr_fut,endyr_fut);

	matrix ssb2_ratio(1,num_str,styr_fut,endyr_fut);
	matrix s_ssb2_ratio(1,num_str,styr_fut,endyr_fut);
	matrix a_ssb2_ratio(1,num_str,styr_fut,endyr_fut);
	matrix ssb3_ratio(1,num_str,styr_fut,endyr_fut);
	matrix s_ssb3_ratio(1,num_str,styr_fut,endyr_fut);
	matrix a_ssb3_ratio(1,num_str,styr_fut,endyr_fut);
	matrix ssb4_ratio(1,num_str,styr_fut,endyr_fut);
	matrix s_ssb4_ratio(1,num_str,styr_fut,endyr_fut);
	matrix a_ssb4_ratio(1,num_str,styr_fut,endyr_fut);
	matrix ssb5_ratio(1,num_str,styr_fut,endyr_fut);
	matrix s_ssb5_ratio(1,num_str,styr_fut,endyr_fut);
	matrix a_ssb5_ratio(1,num_str,styr_fut,endyr_fut);


	matrix rprp(1,num_str,styr_fut,endyr_fut);
	matrix s_rprp(1,num_str,styr_fut,endyr_fut);
	matrix a_rprp(1,num_str,styr_fut,endyr_fut);
	number avgssb;
	number s_avgssb;
	number a_avgssb;


  //---------------
  //standar deviations
  likeprof_number endbiom;
  likeprof_number s_endbio;
  likeprof_number a_endbio;
  sdreport_vector recruits(styr,endyr);
  sdreport_vector biomass(styr,endyr);  
  
  objective_function_value f

PRELIMINARY_CALCS_SECTION

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

RUNTIME_SECTION
  maximum_function_evaluations 200, 400, 600, 800, 800, 800
  convergence_criteria 1e-5,1e-6,1e-7, 1e-7, 1e-7, 1e-7

PROCEDURE_SECTION
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
    Oper_Model();

FUNCTION S_R_parameters

	s_R0 = mean(prop)*mfexp(log_R);
	a_R0 = (1-mean(prop))*mfexp(log_R);
	s_neq(1)=s_R0;
	a_neq(1)=a_R0;
    for(j=2;j<=nages;j++){
    	s_neq(j)=s_neq(j-1)*mfexp(-1.0*s_natmort);
		a_neq(j)=a_neq(j-1)*mfexp(-1.0*a_natmort);
    }
	s_S0=0;
	a_S0=0;
	for(j=1;j<=nages;j++){
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

FUNCTION Oper_Model

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
				s_natage_future(i)(2,nages)=++elem_prod(s_natage_future(i-1)(1,nages-1),s_S_future(i-1)(1,nages-1));
				a_natage_future(i)(2,nages)=++elem_prod(a_natage_future(i-1)(1,nages-1),a_S_future(i-1)(1,nages-1));
				s_natage_future(i,1)=new_prop(i)*mfexp(log_R)*new_rec_epsilon(i);
				a_natage_future(i,1)=(1-new_prop(i))*mfexp(log_R)*new_rec_epsilon(i);
				//numeros sin pesca
				s_natagev_fut(i)(2,nages)=++elem_prod(s_natagev_fut(i-1)(1,nages-1),s_Sv_future(i-1)(1,nages-1));
				a_natagev_fut(i)(2,nages)=++elem_prod(a_natagev_fut(i-1)(1,nages-1),a_Sv_future(i-1)(1,nages-1));
				s_natagev_fut(i,1)=s_natage_future(i,1);
				a_natagev_fut(i,1)=a_natage_future(i,1);				
				
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
					s_sim_HB(i)+=s_sel_reclas(j)*s_wt(j)*s_natage_future(i,j)*s_reclas_epsilon(i);
					a_sim_HB(i)+=a_sel_reclas(j)*a_wt(j)*a_natage_future(i,j)*a_reclas_epsilon(i);
					s_ssbv_future(i)+=s_natagev_fut(i,j)*s_wt(j)*s_mat(j)*mfexp(-.583*s_natmort);
					a_ssbv_future(i)+=a_natagev_fut(i,j)*a_wt(j)*a_mat(j)*mfexp(-.583*a_natmort);
				}
				s_freq.initialize();
				a_freq.initialize();
				ivector s_bin(1,100);
				ivector a_bin(1,100);
				s_sim_p_recage(i)=s_sim_p_recage(i)/sum(s_sim_p_recage(i));
				a_sim_p_recage(i)=a_sim_p_recage(i)/sum(a_sim_p_recage(i));
				s_sim_p_reclen(i)=s_sim_p_recage(i)*s_alk;
				a_sim_p_reclen(i)=a_sim_p_recage(i)*a_alk;
				s_p = value(s_sim_p_reclen(i));
				a_p = value(a_sim_p_reclen(i));
				s_p /=sum(s_p);
				a_p /=sum(a_p);
				s_bin.fill_multinomial(rng,s_p);
				a_bin.fill_multinomial(rng,a_p);
				for(j=1;j<=100;j++){s_freq(s_bin(j))++;a_freq(a_bin(j))++;}
				s_p = s_freq/sum(s_freq);
				a_p = a_freq/sum(a_freq);
				s_sim_p_reclen(i)=s_p; //Composicion por tallas reclas
				a_sim_p_reclen(i)=a_p;				
				
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


FUNCTION get_selectivity

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

FUNCTION get_mortality

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

FUNCTION get_numbers_at_age

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

FUNCTION get_catch_at_age

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

FUNCTION get_predicted_values
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
   ii=yrs_reclas(i);
   s_pred_reclas(i)=0.;
   s_pred_num_reclas(i)=0.;
   a_pred_reclas(i)=0.;
   a_pred_num_reclas(i)=0.;
   t_pred_reclas(i)=0.;
   for (j=1;j<=nages;j++)
    {
		s_pred_num_reclas(i)+=s_sel_reclas(j)*s_natage(ii,j);
		a_pred_num_reclas(i)+=a_sel_reclas(j)*a_natage(ii,j);
		s_pred_reclas(i)+=s_q_reclas*(s_sel_reclas(j)*s_natage(ii,j)*s_wt(j));
		a_pred_reclas(i)+=a_q_reclas*(a_sel_reclas(j)*a_natage(ii,j)*a_wt(i));
		//s_pred_reclas(i)+=q_reclas*(s_sel_reclas(j)*s_natage(ii,j)*s_wt(j));
		//a_pred_reclas(i)+=q_reclas*(a_sel_reclas(j)*a_natage(ii,j)*a_wt(i));
    }
	t_pred_reclas(i)=(s_pred_reclas(i)+a_pred_reclas(i));	
  }
  //PELACES
  for (i=1;i<=nobs_pel;i++)
  {
   ii=yrs_pel(i);
   s_pred_pelaces(i)=0.;
   s_pred_num_pelaces(i)=0.;
   a_pred_pelaces(i)=0.;
   a_pred_num_pelaces(i)=0.;
   t_pred_pelaces(i)=0.;
   for (j=1;j<=nages;j++)
    {
     	s_pred_num_pelaces(i)+=s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j));
     	a_pred_num_pelaces(i)+=a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j));
	 	s_pred_pelaces(i)+=s_q_pelaces*(s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j))*s_wt(j));
	 	a_pred_pelaces(i)+=a_q_pelaces*(a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j))*a_wt(j));
	 	//s_pred_pelaces(i)+=q_pelaces*(s_sel_pelaces(j)*s_natage(ii,j)*mfexp(-0.375*s_Z(ii,j))*s_wt(j));
	 	//a_pred_pelaces(i)+=q_pelaces*(a_sel_pelaces(j)*a_natage(ii,j)*mfexp(-0.375*a_Z(ii,j))*a_wt(j));		
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

  
FUNCTION void do_Newton_Raphson_for_mortality1(int i)
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

FUNCTION void do_Newton_Raphson_for_mortality2(int i)
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

FUNCTION void do_Newton_Raphson_for_mortality(int i)
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

FUNCTION evaluate_the_objective_function  //-Funcion de Verosimilitud-------

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
	surv_like(1)=norm2(log(t_obs_reclas+.1)-log(t_pred_reclas+.1))/(2*square(CV_r))+nobs_reclas*log(CV_r);
    surv_like(2)=norm2(log(s_obs_reclas+.1)-log(s_pred_reclas+.1))/(2*square(CV_r)); //+nobs_reclas*log(CV_r);
    surv_like(3)=norm2(log(a_obs_reclas+.1)-log(a_pred_reclas+.1))/(2*square(CV_r)); //+nobs_reclas*log(CV_r);
    surv_like(4)=norm2(log(t_obs_pel+.1)-log(t_pred_pelaces+.1))/(2*square(CV_p))+nobs_pel*log(CV_p);
    surv_like(5)=norm2(log(s_obs_pel+.1)-log(s_pred_pelaces+.1))/(2*square(CV_p)); //+nobs_pel*log(CV_p);
    surv_like(6)=norm2(log(a_obs_pel+.1)-log(a_pred_pelaces+.1))/(2*square(CV_p)); //+nobs_pel*log(CV_p);
    surv_like(7)=norm2(log(t_obs_mph+.1)-log(t_pred_mph+.1))/(2*square(CV_d))+nobs_mph*log(CV_d);
    surv_like(8)=norm2(log(s_obs_mph+.1)-log(s_pred_mph+.1))/(2*square(CV_d)); //+nobs_mph*log(CV_d);
    surv_like(9)=norm2(log(a_obs_mph+.1)-log(a_pred_mph+.1))/(2*square(CV_d)); //+nobs_mph*log(CV_d);

   //cout << "surv_like "<< surv_like << endl;
	ssqcatch(1)=norm2(log(t_obs_catch+0.1)-log(pred_catch+0.1))/(2*square(CV_y))+size_count(t_obs_catch)*log(CV_y);  //Total catch biomass
	ssqcatch(2)=norm2(log(s_obs_catch+0.1)-log(s_pred_catch+0.1))/(2*square(CV_y))+size_count(s_obs_catch)*log(CV_y);  //Total catch biomass
	ssqcatch(3)=norm2(log(a_obs_catch+0.1)-log(a_pred_catch+0.1))/(2*square(CV_y))+size_count(a_obs_catch)*log(CV_y);  //Total catch biomass

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


REPORT_SECTION

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
   rep(yrs_pel)
   rep(t_obs_pel)
   rep(t_pred_pelaces)
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

TOP_OF_MAIN_SECTION
	arrmblsize = 5000000;
	gradient_structure::set_GRADSTACK_BUFFER_SIZE(10000000);
	gradient_structure::set_CMPDIF_BUFFER_SIZE(5000000);
	gradient_structure::set_MAX_NVAR_OFFSET(5000);
	gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);

  
GLOBALS_SECTION
    #include <admodel.h> 
  #include <string.h>
  adstring s_simname;
  adstring a_simname;
  
  //Mortalidad por pesca
  ofstream rep1("sben_fyr_mcmc",ios::app);
  ofstream rep2("erin_fyr_mcmc",ios::app);

  //Catch
  ofstream rep3("sben_cyr_mcmc",ios::app);
  ofstream rep4("erin_cyr_mcmc",ios::app);
  
  //SSB
  ofstream rep5("sben_syr_mcmc",ios::app);
  ofstream rep6("erin_syr_mcmc",ios::app);
  
  //Biomass
  ofstream rep7("sben_byr_mcmc",ios::app);
  ofstream rep8("erin_byr_mcmc",ios::app);

  //ratio ssb
  ofstream reprat1("s_ssb_rat1_mcmc",ios::app);
  ofstream reprat2("a_ssb_rat1_mcmc",ios::app);
  ofstream reprat3("s_ssb_rat2_mcmc",ios::app);
  ofstream reprat4("a_ssb_rat2_mcmc",ios::app);
  ofstream reprat5("s_ssb_rat3_mcmc",ios::app);
  ofstream reprat6("a_ssb_rat3_mcmc",ios::app);
  ofstream reprat7("s_rpr_mcmc",ios::app);
  ofstream reprat8("a_rpr_mcmc",ios::app);
   
  #undef rep
  #define rep(object) report << #object "\n" << object << endl;
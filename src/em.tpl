//#########################MODELO EVALUACION STOCK INPESCA 2016#############################
//##################Modelo edad-estructurado con ajuste de observaciones de tallas#########################
//############################################################################################
//20 sept2017

DATA_SECTION
  !! *(ad_comm::global_datafile) >>  datafile_name; // First line is datafile 
  !! *(ad_comm::global_datafile) >>  ctlfile_name; // First line is datafile 
  !!ad_comm::change_datafile_name(datafile_name);
  init_int styr  
  init_int endyr
  init_int nages  
  init_vector catch_bio(styr,endyr)  
  init_int nobs_cpue
  init_ivector yr_cpue(1,nobs_cpue)
  init_vector obs_cpue(1,nobs_cpue)
  init_int nobs_surv
  init_ivector yr_surv(1,nobs_surv)
  init_vector obs_surv(1,nobs_surv)
  init_int nobs_survpel
  init_ivector yr_survpel(1,nobs_survpel)
  init_vector obs_survpel(1,nobs_survpel)
  init_int nlenbins                                                                     
  init_int nobs_fishlen                                                              
  init_ivector yr_fishlen(1,nobs_fishlen)                               
  init_ivector yr_fishlenreclas(1,nobs_surv)                             
  init_ivector yr_fishlenpelaces(1,nobs_survpel)   
  init_matrix obs_p_len(1,nobs_fishlen,1,nlenbins)              
  init_matrix obs_p_lenreclas(1,nobs_surv,1,nlenbins)          
  init_matrix obs_p_lenpelaces(1,nobs_survpel,1,nlenbins)  
  init_matrix wta(styr,endyr,1,nages)                                     
 LOCAL_CALCS
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
 END_CALCS


  
  int styr_rec
  int phase_F40; 
  int endyr_fut;
  int styr_fut;
  int dim_sel
  int dim_sel_f1
  
//#################### 
//CONTROLADOR 
//####################
  !!ad_comm::change_datafile_name(ctlfile_name);
  init_int ph_sel_fish             //selectividad
  init_number shif_r               //selectividad
  init_number h                    //escarpamiento
  init_vector crecimiento(1,4)     //parámetros de crecimiento
  init_number M_prior     //parámetros de crecimiento
  init_int opt_VB                  //opcion para estimar o no el crecimiento
  init_int nlen_fish               //n muestreal para longitudes pesqueria
  init_int nlen_fishr              //n muestreal para longitudes reclas
  init_int nlen_fishp              //n muestreal para longitudes pelaces  
  init_number CV_surv              //Coeficiente de variacion para el crucero reclas
  init_number CV_survpel           //Coeficiente de variacion para el crucero pelaces
  init_number CV_catch             //Coef. de Var para las capturas
  init_number CV_cpue              //Coef. de Var para la CPUE
  init_int ph_M                    //inicia fase para estimar M (p.e. la ultima = 5)
  init_int ph_sigmar               //inicia fase sigma reclutamiento
  init_int ph_Fdev                 //inicia fase F mort
  init_int ph_recdev               //inicia fase dev recluta
  init_int ph_q                    //inicia fase estimacion de q para CPUE
  init_int ph_qsurv                //inicia fase de estimacion para el q del crucero
  init_int ph_qsurvpel             //inicia fase de estimacion para el q del crucero pelaces
  init_number natmortprior
  init_number cvnatmortprior
  init_number qprior
  init_number cvqprior
  init_vector edad(1,nages)        //vector de edades reales
  init_vector len(1,nlenbins)      //La marca de clase
  init_vector avgL(1,nages)        //Longitud media por edad
  init_vector obs_CV(1,nages)      //Coef. Variacion por edad
  init_vector wt(1,nages)          //peso promedio stock
  init_vector wti(1,nages)         //peso promedio stock INICIAL
	init_number fecha_desov          //Peak spawning calendar date
	number      SpawnMo_Frac         // convert to elapse time
	!! SpawnMo_Frac = fecha_desov / 12;
	init_number fecha_reclas          //Peak reclas calendar date
	number      reclasMo_Frac         // convert to elapse time
	!! reclasMo_Frac = fecha_reclas / 12;
	init_number fecha_pelaces          //Peak pelaces calendar date
	number      pelacesMo_Frac         // convert to elapse time
	!! pelacesMo_Frac = fecha_pelaces / 12;
  init_vector maturity(1,nages)    //madurez promedio stock
  init_int nselagef1               //selectividad  
  init_int group_num_f1;           //selectividad
  init_int ph_sel_fish1            //selectividad
  init_int ph_seldev_f1            //selectividad
  init_vector lambda(1,3)          //selectividad
  init_number linf;                // CG crecimiento
  init_number k1;
  //init_number t0dat;
  //init_number Cdat;
  //init_number Tsdat; 

//####################  
 LOCAL_CALCS
//####################
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
 END_CALCS   
  init_matrix MLE_catch(1,5,styr_fut,endyr_fut)
  
//####################
INITIALIZATION_SECTION
//####################
  M M_prior
  mean_log_rec1 18
  mean_log_rec 18
  log_Nini 15; 
  log_avg_fmort -3.5  
  log_q_cpue -2.     
  log_q_surv -0.001
  log_q_survpel -0.001
  sigr 0.6;
  log_Bo 8.45;
  a50 .2
  a95 1.8
  a50p .2
  a95p 1.5
  //linf Linfdat   // CG eliminado
  //k1 kdat
  //t0 t0dat

//####################  
PARAMETER_SECTION
//####################  
  init_bounded_number M(0.3,1.7,ph_M)                             
  init_bounded_number log_Lo(1,2.1,-1)                           
  init_bounded_number log_cv_edad(-4,-1.8,-1)
  //init_bounded_number linf(18,21,-1)    CG eliminado                                        
  //init_bounded_number k1(0.3,1.5,-1)  
  //init_bounded_number t0(-1,0.0,-1)    
  init_bounded_number C(0.1,1,-1)     
  init_bounded_number Ts(0.1,1.0,-1) 
  init_bounded_number sigr(0.05,1,ph_sigmar) 
  init_bounded_number log_P(-4,0,-2)    // OjO not really used
  init_bounded_number a50(-4,4,ph_sel_fish) 
  init_bounded_number a95(0.1,7.,ph_sel_fish) 
  init_bounded_number a50p(-4,4,ph_sel_fish)
  init_bounded_number a95p(0.1,7,ph_sel_fish)
  init_bounded_number F60(.01,7.,phase_F40)
  init_bounded_number F40(.01,7.,phase_F40)
  init_bounded_number F20(.01,7.,phase_F40)
  init_bounded_number log_Bo(4,12,-2)    // OjO not really used
  init_bounded_vector rec_dev_future(styr_fut,endyr_fut,-20.,20.,ph_recdev);
  init_bounded_vector cv_age(1,nages,0.02,0.18,-1)  
  init_bounded_dev_vector fmort_dev(styr,endyr,-10,10,ph_Fdev)  
  init_bounded_dev_vector log_dev_ini(2,nages,-10,10,1)
  init_bounded_dev_vector rec_dev(styr,endyr,-20,20,ph_recdev)
  init_bounded_matrix sel_devs_f1(1,dim_sel_f1,1,4,-5.,5.,ph_seldev_f1)  
  init_vector log_selcoffs_f1(1,nselagef1,ph_sel_fish1)
  init_number log_q_surv(ph_qsurv)
  init_number log_q_cpue(ph_q)                                             
  init_number log_q_survpel(ph_qsurvpel)
  init_number mean_log_rec1(1)                                            
  init_number mean_log_rec(1)  
  init_number log_Nini(1)
  init_number log_avg_fmort(1)
  number avgsel_fish1;
  number diff
  number Rlast 
  number Rmedio 
  number Prec
  number sigmar
  number ftmp
  number SB0
  number SBF60
  number SBF40
  number SBF20
  number surv
  number Fmsylast
  number q_fish
  number q_surv
  number q_survpel
  number rec_like
  number cvage_like;
  number catch_like
  number age_like
  number age_liker
  number age_likep
  number sel_like
  number sel_dev_like;
  number fpen
  number cpue_like
  number surv_like
  number surv_likepel
  number cv_edad
  number k
  number Lo
  number BPRo
  number log_Ro
  number alfa
  number beta1
  number beta2
  number offset                                                             
  number offsetr
  number sprpen
  number bmsy;
  number rbmsylast;
  number avg_rec_dev_future
  number offsetp
  number So
  number sumtmp; 
  number sigmar_fut;
  number Kobs_tot_catch;
  vector Nstage(1,nages)
  vector sel_fishr(1,nages)
  vector sel_fishp(1,nages)
  vector Rpred(styr,endyr)
  vector pred_survnum(styr,endyr)
  vector pred_survnump(styr,endyr)   
  vector biomass_future(styr_fut,endyr_fut);
  vector rbmsy(styr,endyr)
  vector sd_age(1,nages)
  vector var_age(1,nages)
  vector bioadul_future(styr_fut,endyr_fut);
  vector ssbiom_future(styr_fut,endyr_fut);
  vector tasa_E(styr,endyr)
  vector BR(styr,endyr)
  vector BR2(styr,endyr)
  vector mu_edad(1,nages);
  vector explbiom(styr,endyr)
  vector bioadul(styr,endyr)
  vector npr(1,nages)
  vector expl_biom(styr_fut,endyr_fut);
  vector ssbiom2P(styr,endyr);
  vector Neq(1,nages)
  vector avg_F_future(1,5)
  vector surv_like_residuals(1,nobs_surv); 
  vector ssqcatch_residuals(styr,endyr); 
  vector surv_like_residualspel(1,nobs_survpel); 
  vector cpue_like_residuals(1,nobs_cpue); 
  vector recruits(styr,endyr);
  matrix age_sel(styr,endyr,1,nages)
  matrix log_sel_f1(styr,endyr,1,nages)
  matrix sel_f1(styr,endyr,1,nages)
  matrix trans(1,nages,1,nlenbins)
  matrix sel_fish(styr,endyr,1,nages)
  matrix age_sel2(styr,endyr,1,nages)
  matrix size_sel(styr,endyr,1,nlenbins)
  matrix size_selr(styr,endyr,1,nlenbins)
  matrix size_selp(styr,endyr,1,nlenbins)
  matrix age_selr(styr,endyr,1,nages)
  matrix age_selp(styr,endyr,1,nages)
  matrix pred_p_age(styr,endyr,1,nages)                 
  matrix pred_p_agereclas(1,nobs_surv,1,nages)     
  matrix pred_p_agepelaces(1,nobs_survpel,1,nages)  
  matrix pred_p_agep(styr,endyr,1,nages)               
  matrix pred_p_len(1,nobs_fishlen,1,nlenbins)         
  matrix pred_p_lenreclas(1,nobs_surv,1,nlenbins)   
  matrix pred_p_lenpelaces(1,nobs_survpel,1,nlenbins) 
  matrix natage(styr,endyr,1,nages)                        
  matrix natage2(styr,endyr,1,nages)                      
  matrix natsize(styr,endyr,1,nlenbins)
  matrix catage(styr,endyr,1,nages)
  matrix Z(styr,endyr,1,nages)
  matrix F(styr,endyr,1,nages)
  matrix S(styr,endyr,1,nages)
  matrix S2(styr,endyr,1,nages)                             
  matrix F_future(styr_fut,endyr_fut,1,nages);
  matrix Z_future(styr_fut,endyr_fut,1,nages);
  matrix S_future(styr_fut,endyr_fut,1,nages);
  matrix catage_future(styr_fut,endyr_fut,1,nages);
  matrix Nspr(1,4,1,nages)
  matrix nage_future(styr_fut,endyr_fut,1,nages)
  matrix pred_p_residual(1,nobs_fishlen,1,nlenbins) 
  matrix pred_p_residualspelaces(1,nobs_survpel,1,nlenbins)
  matrix pred_p_residualsreclas(1,nobs_surv,1,nlenbins)
  matrix catch_future(1,4,styr_fut,endyr_fut); 
  matrix future_biomass(1,5,styr_fut,endyr_fut);
  matrix future_bioadul(1,5,styr_fut,endyr_fut);
  matrix future_ssbiom(1,5,styr_fut,endyr_fut);  
  matrix bio1_ratio(1,5,styr_fut,endyr_fut);  
  matrix bio2_ratio(1,5,styr_fut,endyr_fut);
  likeprof_number endbtot;                                              
  likeprof_number endssb;
  likeprof_number endbadul;
  likeprof_number lastF
  sdreport_vector Fmort(styr,endyr);
  sdreport_vector RPR(styr,endyr);
  sdreport_vector totbiom(styr,endyr);
  sdreport_vector ssbiom(styr,endyr);
  sdreport_vector pred_surv(styr,endyr);
  sdreport_vector pred_cpue(styr,endyr);
  sdreport_vector pred_survpel(styr,endyr);
  sdreport_vector pred_catch(styr,endyr);                

  objective_function_value f
  
//##########################
PRELIMINARY_CALCS_SECTION
//##########################

//Calcula offset para el multinomial pesquería
    for (int i=1; i<= nobs_fishlen; i++)
   {
      obs_p_len(i)/=sum(obs_p_len(i));
      for (int j=1;j <= nlenbins; j++)
      {
        if (obs_p_len(i,j)>0.0)
        {
          offset-=nlen_fish*obs_p_len(i,j)*log(obs_p_len(i,j));
        }
      }
    }

//Calcula offset para el multinomial Reclas
    for (int i=1; i<= nobs_surv; i++)
   {
      obs_p_lenreclas(i)/=sum(obs_p_lenreclas(i));
      for (int j=1;j <= nlenbins; j++)
      {
        if (obs_p_lenreclas(i,j)>0.0)
        {
          offsetr-=nlen_fish*obs_p_lenreclas(i,j)*log(obs_p_lenreclas(i,j));
        }
      }
    }

//Calcula offset para el multinomial Pelaces
    for (int i=1; i<= nobs_survpel; i++)
   {
      obs_p_lenpelaces(i)/=sum(obs_p_lenpelaces(i));
      for (int j=1;j <= nlenbins; j++)
      {
        if (obs_p_lenpelaces(i,j)>0.0)
        {
          offsetr-=nlen_fish*obs_p_lenpelaces(i,j)*log(obs_p_lenpelaces(i,j));
        }
      }
    }
//Arreglo parámetros de crecimiento
  //k1 = kdat; cg eliminado
  //t0 = t0dat;
  //C  = Cdat;  //??? se elimina cg
  //Ts = Tsdat; //??? idem
  get_agematrix();

//###################
PROCEDURE_SECTION
//###################
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
	
//####################	
FUNCTION get_agematrix
//####################
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
	
//#####################
FUNCTION get_selectividad
//#####################
//selectividad pesquería
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
  
//Selectividad Reclas
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

//Selectividad Pelaces
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

//####################  
FUNCTION get_mortalidad
//####################
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
  
//#####################
FUNCTION get_abundancia
//#####################
  int itmp;
  int i;
  int j;
//condición inicial
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
    for (int i=styr;i<=2006;i++) 
    {
      natage(i,1)=mfexp(mean_log_rec+rec_dev(i))+0.5*square(sigr);
    }
    for (int i=2007;i<=endyr;i++)
    {
      natage(i,1)=mfexp(mean_log_rec1+rec_dev(i))+0.5*square(sigr);
    }
    for (int i=styr;i < endyr;i++)
    {
      natage(i+1)(2,nages)=++elem_prod(natage(i)(1,nages-1),S(i)(1,nages-1));
  	  natage(i+1,nages)+=natage(i,nages)*S(i,nages)+natage(i,nages)*S(i,nages);
  	}

//variables estimadas y capturabilidad (pesquería, reclas y pelaces)  
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
//cpue
	  pred_cpue(i)+=q_fish*age_sel(i,j)*natage(i,j)*wta(i,j);    
//crucero reclas
	  pred_surv(i)+=q_surv*natage(i,j)*wta(i,j)*age_selr(i,j)*exp(-reclasMo_Frac*Z(i,j)); 
      pred_survnum(i)+=q_surv*natage(i,j)*age_selr(i,j)*exp(-reclasMo_Frac*Z(i,j));
//cucero pelaces
	  pred_survpel(i)+=q_survpel*natage(i,j)*wta(i,j)*age_selp(i,j)*exp(-pelacesMo_Frac*Z(i,j));
      pred_survnump(i)+=q_survpel*natage(i,j)*age_selp(i,j)*exp(-pelacesMo_Frac*Z(i,j));	  
//variables estado
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

//###################  
FUNCTION get_captura
//###################
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
	
//offset para el multinomial
    for (int i=styr; i<= endyr; i++)
    {
      pred_p_agep(i)=natage(i)/sum(natage(i));
     }
 
//tallas predichas crucero RECLAS
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
  
//tallas predichas crucero PELACES
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
	
//############
FUNCTION spr
//############
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

//###################
FUNCTION proyecciones
//###################

//Abundancia proyectada desde el ultimo año 
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
//Get future F's
     for (int i=styr_fut;i<=endyr_fut;i++)
	 {
		 for (int j=1;j<=nages;j++)
		 {
			 F_future(i,j)=age_sel(endyr,j)*ftmp;
			 Z_future(i,j)=F_future(i,j)+M;
			 S_future(i,j)=exp(-1.*Z_future(i,j));
		 }
	}
//año 1
     ssbiom_future(styr_fut)=0.;
     for (int j=1;j<=nages;j++)
	 {
		 ssbiom_future(styr_fut)+=nage_future(styr_fut,j)*wt(j)*maturity(j)*exp(-SpawnMo_Frac*Z_future(styr_fut,j));
	 }
//año 2
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
//para los demás años
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
//Captura futura
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
	
//#################################
FUNCTION Future_projections_fixed_catch
//#################################
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
//reclutamiento futuro (desovantes)
      nage_future(i,1)=mfexp(rec_dev_future(i)+mean_log_rec);
//resuelve F
        expl_biom(i)=nage_future(i)*elem_prod(age_sel(endyr),wt);
        if (l==5)
         {
          F_future(i)=0.;
         }
        else
         {
         dvariable ffpen=0.0;
// this "kludges" the total catch in case it exceeds the population
         dvariable SK=posfun((expl_biom(i)-catch_future(l,i))/expl_biom(i),0.05,ffpen);
         Kobs_tot_catch=expl_biom(i)-SK*expl_biom(i); 
// hace newton raphson para la capturabilidada
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
//Now graduate for the next year....
         if (i<endyr_fut)
          {
           nage_future(i+1)(2,nages)=++elem_prod(nage_future(i)(1,nages-1),S_future(i)(1,nages-1));
           nage_future(i+1,nages)+=nage_future(i,nages)*S_future(i,nages);
          }
    }
// Now get catch at future ages
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
	
//###########################################	 
FUNCTION void do_Newton_Raphson_for_mortality(int i)
//###########################################
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

//######################
FUNCTION get_stock_recluta
//######################
  So=sum(elem_prod(elem_prod(Nstage*exp(-SpawnMo_Frac*M),maturity),wti));
  alfa=(So/mfexp(mean_log_rec))*(1-h)/(4*h);
  beta1=(5*h-1)/(4*h*mfexp(mean_log_rec));
  beta2=(5*h-1)/(4*h*mfexp(mean_log_rec1)); //1
  bmsy=0.55*So;
  rbmsylast=endssb/bmsy;
  Rpred(styr)= mfexp(mean_log_rec);
  
  for(int i=styr+1;i<=2006;i++)
  {
	Rpred(i)=ssbiom(i-1)/(alfa+beta1*ssbiom(i-1));
    }
  for(int i=2007;i<=endyr;i++)
  {
	Rpred(i)=ssbiom(i-1)/(alfa+beta2*ssbiom(i-1));
    }
  for(int i=styr;i<=endyr;i++)
  {
  rbmsy(i)=ssbiom(i)/bmsy;
    }
	
//##################################  
FUNCTION evaluate_the_objective_function
//##################################
   dvariable temp;
   int ii;
//-Likelihhod desviacion reclutamiento
   rec_like=norm2(rec_dev)/(2*square(sigr))+size_count(rec_dev)*log(sigr);
   if (active(rec_dev_future))
   {
      sigmar_fut=sigr;
      rec_like+=norm2(rec_dev_future)/(2*square(sigmar_fut))+size_count(rec_dev_future)*log(sigmar_fut);
   }
//-Likelihhod composicion por talla pesquería
   age_like=0.;
    for (int i=1; i<=nobs_fishlen; i++)
    {
      for (int j=1; j<=nlenbins; j++)
      {
        age_like-=nlen_fish*obs_p_len(i,j)*log(pred_p_len(i,j)+1.e-13);
      }
    }
   //age_like-=offset;
//-Likelihhod composicion por talla reclas
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
//-Likelihhod composicion por talla pelaces
   age_likep=0.;
    for (int i=1; i<=nobs_survpel; i++)
    {
      for (int j=1; j<=nlenbins; j++)
      {
        age_likep-=nlen_fishp*obs_p_lenpelaces(i,j)*log(pred_p_lenpelaces(i,j)+1.e-13);
      }
    }
    //age_likep-=offsetp;
//-likelihood para Cv edad
   cvage_like=0.;
   cvage_like=10*norm2(cv_edad-obs_CV);
//-likelihood CPUE
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
//-likelihood de capturas
   temp = 0;
   for (int i=styr;i<=endyr;i++)
   {
   temp += square(log(catch_bio(i)/pred_catch(i)));
   }
   catch_like = size_count(catch_bio)*log(CV_catch)+temp/(2.0*square(CV_catch));
   ssqcatch_residuals=(catch_bio-pred_catch)/std_dev(catch_bio);
//-likelihood reclas   
   temp = 0;
   for (int i=1;i<=nobs_surv;i++)
    {
   ii=yr_surv(i);
   temp += square(log(pred_surv(ii)/obs_surv(i)));
   surv_like = nobs_surv*log(CV_surv)+temp/(2.0*square(CV_surv));
   surv_like_residuals=(obs_surv-pred_surv(ii))/std_dev(obs_surv);
    }
//-likelihood pelaces  
	temp = 0;
  for (int i=1;i<=nobs_survpel;i++)
    {
    ii=yr_survpel(i);
    temp += square(log(pred_survpel(ii)/obs_survpel(i)));
    }
  surv_likepel = nobs_survpel*log(CV_survpel)+temp/(2.0*square(CV_survpel)); //
  surv_like_residualspel=(obs_survpel-pred_survpel(ii))/std_dev(obs_survpel);
//-likelihood selectividad caminata aleatoria
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
//opciones
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
 
//penaliza F altos
  if (current_phase()<3)
    fpen= 10.*norm2(mfexp(fmort_dev+log_avg_fmort)-.2);
  else
    fpen= .3*norm2(mfexp(fmort_dev+log_avg_fmort)-.2);
  if (active(fmort_dev))
    fpen+= norm2(fmort_dev);
 
  f+= fpen;
  f+= sprpen;
  
//################  
FUNCTION MCWrite   
//################
//Future_projections_fixed_catch();
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
  
//###############  
REPORT_SECTION
//###############
 if(last_phase()) save_gradients(gradients);
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

//####################
TOP_OF_MAIN_SECTION
//####################
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(1000);
  gradient_structure::set_MAX_NVAR_OFFSET(10000);
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(300000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(6000000);

GLOBALS_SECTION
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


//################  
RUNTIME_SECTION
//################

  maximum_function_evaluations 100, 400, 800, 800
  convergence_criteria 1e-4,1e-6,1e-6, 1e-6

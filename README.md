# B-Spline Density Estimation Library
Supports nonparametric density estimation using B-Spline density estimator from univariate sample.

<b>Estimation methods supported:</b>
<ul>
  <li> Empirical Characteristic Function (ECF):  Cui, Kirkby and Nguyen (2019)</li>
  <li> Galerkin Method: Kirkby, Leitao and Nguyen, (2021) </li>
  <li> "Primal" Basis Estimation: Redner (1999) </li>
</ul>  
  
<b>Bandwidth Selection methods supported:</b>
<ul>
  <li> LCV - Likelihood Cross-Validation </li>
  <li> LSCV - Least-Squares Cross-Validation </li>
  <li> Apdaptive Rule of Thumb - Adaptive heuristic rule of thumb, See Cui, Kirkby and Nguyen (2019) </li>
  <li> Plugin - uses plugin method based on estimate of roughness </li>
  <li> Normal Rule - traditional normal rule of thumb </li>
</ul>


<b>Acknowledgement:</b>
These libraries have been built in collaboration with:
<ul>
  <li><a href="https://www.researchgate.net/profile/Justin_Kirkby"> Justin Lars Kirkby </a> </li>
    <li><a href="https://www.researchgate.net/profile/Alvaro-Leitao-Rodriguez">Alvaro Leitao-Rodriguez </a> </li>
  <li><a href="https://www.researchgate.net/profile/Duy_Nguyen125">Duy Nguyen </a> </li>
  <li><a href="https://www.researchgate.net/profile/Zhenyu_Cui"> Zhenyu Cui </a> </li>
</ul>

<b> Supporting Research Articles: </b>

<ul>
  <li> 
    <a href="https://www.researchgate.net/publication/333322127_NONPARAMETRIC_DENSITY_ESTIMATION_BY_B-SPLINE_DUALITY">Nonparametric Density Estimation by B-spline Duality. Econometric Theory (2019)</a>
  </li>
  <li> <a href="https://www.researchgate.net/publication/348609092_Nonparametric_Density_Estimation_and_Bandwidth_Selection_with_B-spline_bases_a_Novel_Galerkin_Method"> Nonparametric Density Estimation and Bandwidth Selection with B-spline bases: a Novel Galerkin Method. Computational Statistics and Data Analysis (2021)</a> 
  </li>
  <li> <a href="https://www.researchgate.net/publication/342693067_A_data-driven_framework_for_consistent_financial_valuation_and_risk_measurement"> A data-driven framework for consistent financial valuation and risk measurement. Eur. J. Operational Research (2020) </a>
  </li>
</ul>




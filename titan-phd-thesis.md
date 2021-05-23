---
title: Improving the Environmental Stability of Methylammonium-Based Perovskite Solar Cells
---

[Index](index.md) >> [Thesis](thesis.md)

PhD Thesis Defense
Improving the Environmental Stability of Methylammonium-Based Perovskite Solar Cells
Titan Hartono

Comittee Members
Prof. Tonio
Prof. Betar Gallant
Prof. Rafael

1. screening & identifying design guidelines for capping layer materials (paper)
data-driven screening
possibly machine learning
workflow: capping material selection -> film fabrication -> degradation & image acquisition on films-> degradation onset extraction -> regression models using scikit-learn & feature importance using SHAP -> capping layer desing guidelines; in depth material characterizations; materials data from pubchem database 2019

2. improving mixed-halide absorber stability for tandem cells & indoor pv
tandem cells: wide-bandgap absorber
indoor pv applications: wider bandgap absorbers
tune perovskite bandgap by mixing halides (I- -> Br-)
photoinduced segregation -> increase possibility of secondary phase formation -> accelerates degradation
workflow: capping layers pteai + absorber mixture -> stability secreening using -> faster dagradation -> optoelectroy -> analysze
capping layers: sum the rgb value and construct instability metric (change in differential area t0 -> t)
capture dissimilarity matrix to summarize
dissimilarity matrix helps screen capping layer-absorber pairs faster
surface photovoltage indicates a change in the films surface charge -> charge change impact degradation
degradation routes:
a. anion drift due to electrostatic charge: ionic imbalance -> accelerates secondary phase formation; bias v, heat x
b. deprotonation of capping layer organics: stronger acidity increase likelihood of giving up proton; o2 v, humidity x, light v, heat x
c. crystal structure/layer change: O2 v, humidity v
d. oxygen adsorption due to superoxide formation; o2 v, humidity x, light v, heat v
conclusions:
- 9-cl pteai
- minimum stability
- 4 routes of degradation

3. how about inverted (p-i-n) architecture?
electron transport layer: where to put capping layer?
discovered a new method to deposit capping layer in bottom configuration

future works:
- capping layer is not the only strategy
- we need move from film layer to multilayer optimization

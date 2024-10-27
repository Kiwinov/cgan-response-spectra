# Response Spectra generation with CGAN
A Conditional Generative Adversarial Network (CGAN) is used to generate response spectra corresponding to a specific earthquakes, each of which is characterised by 6 specific input parameters:
1. Earthquake Magnitude
1. Joyner-Boore distance
1. Logarithm of Joyner-Boore distance
1. Mechanism Based on Rake Angle
1. Preferred shear wave velocity ($VS_{30}$)
1. Depth

## Model Specifications
The CGAN model uses two Feed-Forward Neural Networks for generation and discrimination (classification) respectively.

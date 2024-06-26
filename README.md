# Response Spectra generation with CGAN
Conditional Generative Adversarial Network is used to generate response spectra corresponding to a specific earthquake characterised by 6 specific input parameters:
1. Earthquake Magnitude
1. Joyner-Boore distance
1. Logarithm of Joyner-Boore distance
1. Mechanism Based on Rake Angle
1. Preferred shear wave velocity ($VS_30$)
1. Depth

## Contents
1. `PyTorch_Conditional_GAN.ipynb` is the Jupyter Notebook used for training, evaluation and generation of Response Spectra
2. `Earthquake_GM_Prediction.pdf` is the presentation of the project

## Model Specifications
The CGAN model uses two Feed-Forward Neural Networks for generation and discrimination (classification) respectively.

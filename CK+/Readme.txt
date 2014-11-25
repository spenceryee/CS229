--------------------------------------------------------------------------------------
The Extended Cohn-Kanade (CK+) database distribution: PHASE 1
Initial: 1st July 2010
Revised: 28th Sept 2010
---------------------------------------------------------------------------------------

In this Phase there are 4 zipped up files. They relate to:

1) The Images (cohn-kanade-images.zip) -  there are 593 sequences across 123 subjects which are FACS coded at the peak frame. All sequences are from the neutral face to the peak expression.

2) The Landmarks (Landmarks.zip) - All sequences are AAM tracked with 68points landmarks for each image. 

3) The FACS coded files (FACS_labels.zip) - for each sequence (593) there is only 1 FACS file, which is the last frame (the peak frame). Each line of the file corresponds to a specific AU and then the intensity. An example is given below.

4) The Emotion coded files (Emotion_labels.zip) - ONLY 327 of the 593 sequences have emotion sequences. This is because these are the only ones the fit the prototypic definition. Like the FACS files, there is only 1 Emotion file for each sequence which is the last frame (the peak frame). There should be only one entry and the number will range from 0-7 (i.e. 0=neutral, 1=anger, 2=contempt, 3=disgust, 4=fear, 5=happy, 6=sadness, 7=surprise). N.B there is only 327 files- IF THERE IS NO FILE IT MEANS THAT THERE IS NO EMOTION LABEL (sorry to be explicit but this will avoid confusion).


Examples:
-----------------------------------------------------------------------------------

All file name and structure should be the same. For example, an image
at:

cohn-kanade-images/S005/001/S005_001_00000011.png
------------------------------------------------------------------------------------
will have the corresponding landmark at:

Landmarks/S005/001/S005_001_00000011_landmarks.txt
------------------------------------------------------------------------------------
FACS code at:

FACS/S005/001/S0005_001_00000011_facs.txt

which has

9.0000000e+00   4.0000000e+00
1.7000000e+01   2.0000000e+00

this means that AU9d and AU17b are present
N.B if an AU is present but the intensity is 0 this means that the
intensity was not given

e.g.

1.20000000e+00 0.000000000e+00

just means AU12 (intensity not given).

------------------------------------------------------------------------------------
Emotion code at:

Emotion/S005/001/S005_001_00000011_emotion.txt

which has
3.00000000e+00

that is disgust
--------------------------------------------------------------------------------------

Soon we will release Phase 2 which will contain the non-posed smiles portion of the dataset. Phase 3 will contain the non-frontal synchronous data. Please see website for updates. 

For full details see:

P. Lucey, J.F. Cohn, T. Kanade, J. Saragih, Z. Ambadar and I. Matthews, "The Extended Cohn-Kanade Dataset (CK+): A complete dataset for action unit and emotion-specified expression", in the Proceedings of IEEE workshop on CVPR for Human Communicative Behavior Analysis, San Francisco, USA, 2010. 

If you find any further discrepancies could you please email me at pjlucey@gmail.com

Acknowledgments:
We would like to thank Marni Bartlett and Tingfan Wu for alerting us to the initial discrepancies. 


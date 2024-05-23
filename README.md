# GFT-Based-Audio-Zero-Watermarking
We propose a novel audio zero-watermarking technology based on graph Fourier transform for enhancing the robustness with respect to copyright protection. In this approach, the combined shift operator is used to construct the graph signal, upon which the graph Fourier analysis is performed. The selected maximum absolute graph Fourier coefficients representing the characteristics of the audio segment are then encoded into a feature binary sequence using K-means algorithm. Finally, the resultant feature binary sequence is XOR-ed with the watermark binary sequence to realize the embedding of the zero-watermarking.

Usage
-------------------------------------------------
Run GSP_kmeans.m

Citation
-----------------------------------------------
Please cite the following if our paper or code is helpful to your research.

@article{2021Graph,
  title={Graph Fourier Transform based Audio Zero-watermarking},
  author={ Xu, Longting  and  Huang, Daiyu  and  Zaidi, Syed Faham Ali  and  Rauf, Abdul  and  Das, Rohan Kumar },
  year={2021},
}

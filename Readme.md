# Introduction
The main focus of this project is to explore and implement a lossy encoder and decoder for static images and videos. Building upon the existing foundation, optimizations have been introduced, including fractional-sample-accurate motion compensation (MCP) and intra-coding for both inter- and intra-prediction.

## DCT-based still image coding 
* In the process of encoding still images, the main techniques applied include Discrete Cosine Transform (DCT), quantization, zigzag scanning, run-level coding, and Huffman coding
![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/b8fb0173-ba24-4d29-adef-bd7132735f8b)

## Hybrid video coder (with embedded decoder)
* In the process of encoding static images, the main techniques applied include Discrete Cosine Transform (DCT), quantization, zigzag scanning, run-level coding, and Huffman coding
![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/df3e02ad-5511-4f9a-acc0-5b638e26d6c0)
![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/9d812d84-1ce3-45d4-9ad5-d71fa072af5e)

## Fractional-sample-accurate MCP and intra Coding for inter- and intra-prediction
Here we want to use fractional-pixel (e.g half-pixel) instead of full pixel for higher accuracy. We use linear interpolation and assign the mean of the four surrounding points to the interpolation point. In intra coding we encode the residual difference between predicted and actual block samples from different direction.

### Intra Coding
* Based on prediction from previously decoded spatially neighboring samples.
* Different location of blocks have different prediction method
* Calculate SAD, the winning mode is the one with the smallest error
* ![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/a40df21b-9210-44c7-9a8a-aa7cb2804f5c)

### Half-sample-accurate MCP
* Use the neighboring 6 pixels to predict the value of the center pixel
* e.g. $b = \frac{E-5F+20G+20H-5I+J}{32}$
* ![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/cb9130b8-d2f5-4acb-a3a3-dde06bcb6a4a)

### Result
![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/0d23d84e-c250-43ba-b614-77adbcad9445)
![picture](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/e4ea7481-0a54-468a-9e26-168b34fddc00)

## Manual
- Please open and run main.m  until it finishes running, It will take about 20 minutes.






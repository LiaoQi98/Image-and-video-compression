# LAB IVC final optimization
Hybrid video coder (with embedded decoder)
![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/df3e02ad-5511-4f9a-acc0-5b638e26d6c0)

## Fractional-sample-accurate MCP and intra Coding for inter- and intra-prediction
Here we want to use fractional-pixel (e.g half-pixel) instead of full pixel for higher accuracy. We use linear interpolation and assign the mean of the four surrounding points to the interpolation point. In intra coding we encode the residual difference between predicted and actual block samples from different direction.


![image](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/0d23d84e-c250-43ba-b614-77adbcad9445)
![picture](https://github.com/LiaoQi98/Image-and-video-compression/assets/108174052/e4ea7481-0a54-468a-9e26-168b34fddc00)


## Manual
- Please open and run main.m  until it finishes running






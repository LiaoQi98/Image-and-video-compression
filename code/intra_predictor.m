function  [result,zz,cof] = intra_predictor(block,mode,qScale,prev_hori,prev_verti,prev_verti2,diagvalue)
    switch mode
        case 1
            coeff = DCT8x8(block);
            quant = Quant8x8(coeff, qScale);
            zz    = ZigZag8x8(quant);
            recon_block = DeQuant8x8(quant,qScale);
            result = IDCT8x8(recon_block);
            cof = "";
            
        case 2
            [error,predict] = predict_mode0(block,prev_hori,prev_verti);
            coeff = DCT8x8(error);
            quant = Quant8x8(coeff,qScale);  
            zz    = ZigZag8x8(quant);
            recon_block = DeQuant8x8(quant,qScale);
            result = IDCT8x8(recon_block)+predict;
            cof = '00';
        case 3
            [error1,predict1] = predict_mode1(block,prev_hori,prev_verti);
            [error2,predict2] = predict_mode4(block,prev_verti,prev_verti2);
            [error,predict,cof] = cal_sad3(block,error1,predict1,error2,predict2);
            coeff = DCT8x8(error);
            quant = Quant8x8(coeff,qScale);  
            zz    = ZigZag8x8(quant);
            recon_block = DeQuant8x8(quant,qScale);
            result = IDCT8x8(recon_block)+predict;
            %cof = '01';
        case 4
            [error1,predict1] = predict_mode0(block,prev_hori,prev_verti);
            [error2,predict2] = predict_mode1(block,prev_hori,prev_verti);
            [error3,predict3] = predict_mode2(block,prev_hori,prev_verti,diagvalue);
            [error4,predict4] = predict_mode3(block,prev_hori,prev_verti);
            [error5,predict5] = predict_mode4(block,prev_verti,prev_verti2);
            [error,predict,cof] = cal_sad1(block,error1,predict1,error2,predict2,error3,predict3,error4,predict4,error5,predict5);
            coeff = DCT8x8(error);
            quant = Quant8x8(coeff,qScale);  
            zz    = ZigZag8x8(quant);
            recon_block = DeQuant8x8(quant,qScale);
            result = IDCT8x8(recon_block)+predict;

        case 5
            [error1,predict1] = predict_mode0(block,prev_hori,prev_verti);
            [error2,predict2] = predict_mode1(block,prev_hori,prev_verti);
            [error3,predict3] = predict_mode2(block,prev_hori,prev_verti,diagvalue);
            [error4,predict4] = predict_mode3(block,prev_hori,prev_verti);
            [error,predict,cof] = cal_sad2(block,error1,predict1,error2,predict2,error3,predict3,error4,predict4);
            coeff = DCT8x8(error);
            quant = Quant8x8(coeff,qScale);  
            zz    = ZigZag8x8(quant);
            recon_block = DeQuant8x8(quant,qScale);
            result = IDCT8x8(recon_block)+predict;
            
    end
    result(result(:,:,1) > 255) = 255;
    result(result(:,:,1) < 0  ) = 0;
end

function [error,predict,cof] = cal_sad1(image_block,error1,predict1,error2,predict2,error3,predict3,error4,predict4,error5,predict5)
    
    if sum(abs(image_block-predict1)) < sum(abs(image_block-predict2))
        error = error1;
        predict = predict1;
        cof = "00";
    else
        error = error2;
        predict = predict2;
        cof = "01";
    end

    if sum(abs(image_block-predict3))< sum(abs(image_block-predict))
        error = error3;
        predict = predict3;
        cof = "10";
    end

    if sum(abs(image_block-predict4))< sum(abs(image_block-predict))
        error = error4;
        predict = predict4;
        cof = "110";
    end

    if sum(abs(image_block-predict5))< sum(abs(image_block-predict))
        error = error5;
        predict = predict5;
        cof = "111";
    end

end

function [error,predict,cof] = cal_sad2(image_block,error1,predict1,error2,predict2,error3,predict3,error4,predict4)
    
    if sum(abs(image_block-predict1)) < sum(abs(image_block-predict2))
        error = error1;
        predict = predict1;
        cof = "00";
    else
        error = error2;
        predict = predict2;
        cof = "01";
    end

    if sum(abs(image_block-predict3))< sum(abs(image_block-predict))
        error = error3;
        predict = predict3;
        cof = "10";
    end

    if sum(abs(image_block-predict4))< sum(abs(image_block-predict))
        error = error4;
        predict = predict4;
        cof = "110";
    end



end
    
function [error,predict,cof] = cal_sad3(image_block,error1,predict1,error2,predict2)
    
    if sum(abs(image_block-predict1)) < sum(abs(image_block-predict2))
        error = error1;
        predict = predict1;
        cof = "00";
    else
        error = error2;
        predict = predict2;
        cof = "01";
    end

end
 
function [error,predict] = predict_mode0(image_block,prev_hori,prev_verti)
    [x,y,z] = size(image_block);
    predict = zeros(size(image_block));
    for i = 1:z
        predict(:,:,i) = repmat(prev_hori(:,:,i),1,y);
    end
    error = image_block - predict;

end

function [error,predict] = predict_mode1(image_block,prev_hori,prev_verti)
    [x,y,z] = size(image_block);
    predict = zeros(size(image_block));
    for i = 1:z
        predict(:,:,i) = repmat(prev_verti(:,:,i),x,1);
    end
    error = image_block - predict;
end

function [error,predict] = predict_mode2(image_block,prev_hori,prev_verti,diagonalvalue)
    predict = zeros(size(image_block));
    [x,y,z] = size(image_block);
    for k = 1:z
        predict(:,:,k) = diag(diagonalvalue(:,:,k)*ones(1,x));
    end
    
    for k = 1:z
        for i = 1:x
            predict(i,i+1:end,k) = prev_verti(1,1:end-i,k);
        end
        for i = 1:y
            predict(i+1:end,i,k) = prev_hori(1:end-i,1,k);
        end
    end
    error = image_block - predict;
end

function [error,predict] = predict_mode3(image_block,prev_hori,prev_verti)
    predict = ones(8,8,3);
    predict(:,:,1) = mean([prev_hori(:,:,1);prev_verti(:,:,1)']);
    predict(:,:,2) = mean([prev_hori(:,:,2);prev_verti(:,:,2)']);
    predict(:,:,3) = mean([prev_hori(:,:,3);prev_verti(:,:,3)']);
    error = image_block - predict;
end

function [error,predict] = predict_mode4(image_block,prev_verti1,prev_verti2)
    [x,y,z] = size(image_block);
    predict = zeros(size(image_block));

    for k = 1:z
        for i = 1:x-1
            predict(i,1:x-i,k) = prev_verti1(1,i+1:end,k);
        end
        for j = 1:y
            predict(y-j+1:end,j,k) = prev_verti2(1,1:j,k);
        end
    end
    error = image_block - predict;

end


#! /bin/bash

printf -v now '%(%F_%H-%M-%S)T' -1
exp_name="imagenet_$1_$now"
exp_create_str=$(mlflow experiments create -n $exp_name)
echo $exp_create_str
exp_id=$(echo $exp_create_str | awk '{print $NF}')

for m in "ConvNeXtBase" "ConvNeXtSmall" "ConvNeXtTiny" "DenseNet121" "DenseNet169" "DenseNet201" "EfficientNetB0" "EfficientNetB1" "EfficientNetB2" "EfficientNetB3" "EfficientNetB4" "EfficientNetB5" "EfficientNetB6" "EfficientNetB7" "EfficientNetV2B0" "EfficientNetV2B1" "EfficientNetV2B2" "EfficientNetV2B3" "EfficientNetV2L" "EfficientNetV2M" "EfficientNetV2S" "InceptionResNetV2" "InceptionV3" "MobileNet" "MobileNetV2" "NASNetLarge" "NASNetMobile" "ResNet50" "ResNet101" "ResNet152" "ResNet50V2" "ResNet101V2" "ResNet152V2" "Xception" "MobileNetV3Large" "MobileNetV3Small" # "ConvNeXtLarge" "ConvNeXtXLarge" "VGG16" "VGG19"
do
    for g in "0" "1"
    do
        mlflow run --experiment-name=$exp_name -e main.py -P model=$m -P datadir=/data/d1/fischer_diss/imagenet -P subset=$1 -P nogpu=$g ./experiments/imagenet
        sleep 15
    done
done

mlflow experiments csv -x $exp_id > "$exp_name.csv"
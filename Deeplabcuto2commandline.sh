### Alex Zhang and Bruno Boivin

# lable images using ImageJ

# launching dir: ~/DeepLabCut-100by100/
# for you: ~/{your deeplabcut}/

srun -n 1 --pty --mem 32G -t 11:59:00 -p gpu --gres=gpu:1 /bin/bash
# launching a interactive session of GPU computing node
module load gcc/6.2.0 cuda/9.0 python/3.6.0
# load the modules
source GPUIDpaw2/bin/activate
# activate virtualenv
cp {your folder with images and labels}/* ~/DeepLabCut-100by100/Generating_a_Training_Set/data-reaching/reachingvideo1/
#copy labeled train/test set to the right folder

cd ~/DeepLabCut-100by100
vim myconfig.py # and edit line 38 accordingly
# 'change myconfig file to specific task accordingly'

cd ~/DeepLabCut-100by100/Generating_a_Training_Set/
python3 Step2_ConvertingLabels2DataFrame.py

#output: Merging scorer's data.

python3 Step3_CheckLabels.py

#output: 6
#<map object at 0x7fab934ae438>
#['snout', 'frontleft', 'hindleft', 'tailbase', 'backrightpaw', 'frontrightpaw']
#['reachingvideo1']
#Creating images with labels by  Mackenzie

python3 Step4_GenerateTrainingFileFromLabelledData.py

cp -R ~/DeepLabCut-100by100/Generating_a_Training_Set/reachingJan30-trainset95shuffle1 ~/DeepLabCut-100by100/pose-tensorflow/models/
cp -R ~/DeepLabCut-100by100/Generating_a_Training_Set/UnaugmentedDataSet_reachingJan30/ ~/DeepLabCut-100by100/pose-tensorflow/models/

cd ~/DeepLabCut-100by100/pose-tensorflow/models/pretrained
bash download

#download pretrained resnet-50 and resnet-100

cd ~/DeepLabCut-100by100/pose-tensorflow/models/reachingJan30-trainset95shuffle1/train
python3 ~/DeepLabCut-100by100/pose-tensorflow/train.py

#training started

# for this step, you can also exit the interactive session and submit training job through sbatch


#after training, test the trained NN
cd ~/DeepLabCut-100by100/Evaluation-Tools
python3 Step1_EvaluateModelonDataset.py
python3 Step2_AnalysisofResults.py

#output: Results: 95 1 train error: 1.4744280554712001 test error: 40.06420953680307

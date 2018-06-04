

module load gcc/6.2.0 cuda/9.0 python/3.6.0
source GPUIDpaw2/bin/activate
cd /home/zz90/DeepLabCut-master/pose-tensorflow/models/reachingJan30-trainset95shuffle1/train
python3 /home/zz90/DeepLabCut-master/pose-tensorflow/train.py

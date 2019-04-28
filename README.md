VisDrone2019-DET Toolkit for Object Detection in Images

Introduction

This is the documentation of the VisDrone2018 competitions development kit for object detection in images (DET) challenge.

This code library is for research purpose only, which is modified based on the PASCAL VOC [1] and MS-COCO [2] platforms.

The code is tested on the Windows 10 and macOS Sierra 10.12.6 systems, with the Matlab 2013a/2014b/2016b/2017b platforms.

If you have any questions, please contact us (email:tju.drone.vision@gmail.com).

Citation

If you use our toolkit or dataset, please cite our paper as follows:

@article{zhuvisdrone2018,

title={Vision Meets Drones: A Challenge},

author={Zhu, Pengfei and Wen, Longyin and Bian, Xiao and Haibin, Ling and Hu, Qinghua},

journal={arXiv preprint:1804.07437},

year={2018}
}

@InProceedings{Zhu_2018_ECCV_Workshops,
author = {Zhu, Pengfei and Wen, Longyin and Du, Dawei and Bian, Xiao and Ling, Haibin and Hu, Qinghua and Nie, Qinqin and Cheng, Hao and Liu, Chenfeng and Liu, Xiaoyu and Ma, Wenya and Wu, Haotian and Wang, Lianjie and Schumann, Arne and Brown, Chase and Qian, Chen and Li, Chengzheng and Li, Dongdong and Michail, Emmanouil and Zhang, Fan and Ni, Feng and Zhu, Feng and Wang, Guanghui and Zhang, Haipeng and Deng, Han and Liu, Hao and Wang, Haoran and Qiu, Heqian and Qi, Honggang and Shi, Honghui and Li, Hongliang and Xu, Hongyu and Lin, Hu and Kompatsiaris, Ioannis and Cheng, Jian and Wang, Jianqiang and Yang, Jianxiu and Zhou, Jingkai and Zhao, Juanping and Joseph, K. J. and Duan, Kaiwen and Suresh, Karthik and Bo, Ke and Wang, Ke and Avgerinakis, Konstantinos and Sommer, Lars and Zhang, Lei and Yang, Li and Cheng, Lin and Ma, Lin and Lu, Liyu and Ding, Lu and Huang, Minyu and Kumar Vedurupaka, Naveen and Mamgain, Nehal and Bansal, Nitin and Acatay, Oliver and Giannakeris, Panagiotis and Wang, Qian and Zhao, Qijie and Huang, Qingming and Liu, Qiong and Cheng, Qishang and Sun, Qiuchen and Laganire, Robert and Jiang, Sheng and Wang, Shengjin and Wei, Shubo and Wang, Siwei and Vrochidis, Stefanos and Wang, Sujuan and Lee, Tiaojio and Sajid, Usman and Balasubramanian, Vineeth N. and Li, Wei and Zhang, Wei and Wu, Weikun and Ma, Wenchi and He, Wenrui and Yang, Wenzhe and Chen, Xiaoyu and Sun, Xin and Luo, Xinbin and Lian, Xintao and Li, Xiufang and Kuai, Yangliu and Li, Yali and Luo, Yi and Zhang, Yifan and Liu, Yiling and Li, Ying and Wang, Yong and Wang, Yongtao and Wu, Yuanwei and Fan, Yue and Wei, Yunchao and Zhang, Yuqin and Wang, Zexin and Wang, Zhangyang and Xia, Zhaoyue and Cui, Zhen and He, Zhenwei and Deng, Zhipeng and Guo, Zhiyao and Song, Zichen},
title = {VisDrone-DET2018: The Vision Meets Drone Object Detection in Image Challenge Results},
booktitle = {The European Conference on Computer Vision (ECCV) Workshops},
month = {September},
year = {2018}
}

Dataset

For DET competition, there are three sets of data and labels: training data, validation data, and test-challenge data. There is no overlap between the three sets.

                                                            Number of images
    ---------------------------------------------------------------------------------------------------
      Dataset                            Training              Validation            Test-Challenge
    ---------------------------------------------------------------------------------------------------
      Object detection in images       6,471 images            548 images             1,580 images
    ---------------------------------------------------------------------------------------------------
The challenge requires a participating algorithm to locate the target bounding boxes in each image. The objects to be detected are of various types including pedestrians, cars, buses, and trucks. We manually annotate the bounding boxes of different objects and ignored regiones in each image. Annotations on the training and validation sets are publicly available.

The link for downloading the data can be obtained by registering for the challenge at

http://www.aiskyeye.com/
Evaluation Routines

The notes for the folders:

evalDET.m is the main function used to evaluate your detector -please modify the dataset path and result path -use "isImgDisplay" to display the groundtruth and detections

DET Submission Format

Submission of the results will consist of TXT files with one line per predicted object.It looks as follows:

     <bbox_left>,<bbox_top>,<bbox_width>,<bbox_height>,<score>,<object_category>,<truncation>,<occlusion>


        Name                                                  Description
    -------------------------------------------------------------------------------------------------------------------------------     
     <bbox_left>	     The x coordinate of the top-left corner of the predicted bounding box
  
     <bbox_top>	     The y coordinate of the top-left corner of the predicted object bounding box
  
     <bbox_width>	     The width in pixels of the predicted object bounding box
 
    <bbox_height>	     The height in pixels of the predicted object bounding box
 
       <score>	     The score in the DETECTION file indicates the confidence of the predicted bounding box enclosing 
                         an object instance.
                         The score in GROUNDTRUTH file is set to 1 or 0. 1 indicates the bounding box is considered in evaluation, 
                         while 0 indicates the bounding box will be ignored.
                          
    <object_category>    The object category indicates the type of annotated object, (i.e., ignored regions(0), pedestrian(1), 
                         people(2), bicycle(3), car(4), van(5), truck(6), tricycle(7), awning-tricycle(8), bus(9), motor(10), 
                         others(11))
                          
    <truncation>	     The score in the DETECTION result file should be set to the constant -1.
                         The score in the GROUNDTRUTH file indicates the degree of object parts appears outside a frame 
                         (i.e., no truncation = 0 (truncation ratio 0%), and partial truncation = 1 (truncation ratio 1% ~ 50%)).
                          
    <occlusion>	     The score in the DETECTION file should be set to the constant -1.
                         The score in the GROUNDTRUTH file indicates the fraction of objects being occluded (i.e., no occlusion = 0 
                         (occlusion ratio 0%), partial occlusion = 1 (occlusion ratio 1% ~ 50%), and heavy occlusion = 2 
                         (occlusion ratio 50% ~ 100%)).
   ------------------------------------------------------------------------------------------------------------------------------
The detections in the ignored regions or labeled as "others" will be not considered in evaluation. The sample submission of the Faster-RCNN detector can be found in our website.

References

[1] E. Park, W. Liu, O. Russakovsky, J. Deng, F.-F. Li, and A. Berg, "Large Scale Visual Recognition Challenge 2017", http://imagenet.org/challenges/LSVRC/2017 
[2] T. Lin, M. Maire, S. J. Belongie, J. Hays, P. Perona, D. Ramanan, P. Dollar, and C. L. Zitnick, "Microsoft COCO: common objects in context", in ECCV 2014.

Version History

1.0.4 - Apr 28, 2019

The readme file is updated.

1.0.3 - Jun 29, 2018

The nms function is removed to avoid confusion.
The detections in ignored regions are removed.
The bugs to calculate the overlap score are fixed.

1.0.2 - Apr 27, 2018

The nms function is included.
The annotations in ignored regions are removed.

1.0.1 - Apr 25, 2018

The display function of groundtruth and detection results are included.

1.0.0 - Apr 19, 2018

Initial release.

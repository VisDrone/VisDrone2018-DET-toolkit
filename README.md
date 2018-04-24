VisDrone2018-DET Toolkit for Object Detection in Images

Introduction

This is the documentation of the VisDrone2018 competitions development kit for object detection in images (DET) challenge.

This code library is for research purpose only, which is modified based on the MS-COCO [1] platforms. 

The code is tested on the Windows 10 and macOS Sierra 10.12.6 systems, with the Matlab 2013a/2014b/2016b/2017b platforms.

If you have any questions, please contact us (email:tju.drone.vision@gmail.com).


Dataset

For DET competition, there are three sets of data and labels: training data, validation data, 
and test-challenge data. There is no overlap between the three sets. 

                                                           Number of images
    ----------------------------------------------------------------------------------------------
    Dataset                            Training              Validation            Test-Challenge
    ----------------------------------------------------------------------------------------------
    Object detection in images       6,471 images            548 images             1,610 images
    ----------------------------------------------------------------------------------------------
    
The challenge requires a participating algorithm to locate the target bounding boxes in each image. The objects to be detected are of various types including pedestrians, cars, buses, and trucks. We manually annotate the bounding boxes of different objects and ignored regiones in each image. Annotations on the training and validation sets are publicly available.

The link for downloading the data can be obtained by registering for the challenge at

    http://www.aiskyeye.com/
 

Evaluation Routines

The notes for the folders:
* main functions
	* calcAccuracy.m is the main function to evaluate your detector
        -modify the dataset path and result path    
    

DET Submission Format

Submission of the results will consist of TXT files with one line per predicted object.It looks as follows:

    <target_id>,<bbox_left>,<bbox_top>,<bbox_width>,<bbox_height>,<score>,<object_category>,<truncation>,<occlusion>


          Name                                                  Description
    -------------------------------------------------------------------------------------------------------------------------------
      <target_id>	         In the DETECTION result file, the identity of the target should be set to the constant -1. 
                             In the  GROUNDTRUTH file, the identity of the target is used to provide the temporal corresponding 
                             relation of the bounding boxes in different frames.
                              
      <bbox_left>	         The x coordinate of the top-left corner of the predicted bounding box
      
      <bbox_top>	         The y coordinate of the top-left corner of the predicted object bounding box
      
     <bbox_width>	         The width in pixels of the predicted object bounding box
     
     <bbox_height>	         The height in pixels of the predicted object bounding box
     
        <score>	         The score in the DETECTION file indicates the confidence of the predicted bounding box enclosing 
                             an object instance.
                             The score in GROUNDTRUTH file is set to 1 or 0. 1 indicates the bounding box is considered in evaluation, 
                             while 0 indicates the bounding box will be ignored.
                              
    <object_category>	 The object category indicates the type of annotated object, (i.e., ignored regions(0), pedestrian(1), 
                             people(2), bicycle(3), car(4), van(5), truck(6), tricycle(7), awning-tricycle(8), bus(9), motor(10), 
                             others(11))
                              
     <truncation>	         The score in the DETECTION result file should be set to the constant -1.
                             The score in the GROUNDTRUTH file indicates the degree of object parts appears outside a frame 
                             (i.e., no truncation = 0 (truncation ratio 0%), and partial truncation = 1 (truncation ratio 1% ~ 50%)).
                              
      <occlusion>	         The score in the DETECTION file should be set to the constant -1.
                             The score in the GROUNDTRUTH file indicates the fraction of objects being occluded (i.e., no occlusion = 0 
                             (occlusion ratio 0%), partial occlusion = 1 (occlusion ratio 1% ~ 50%), and heavy occlusion = 2 
                             (occlusion ratio 50% ~ 100%)).
    ------------------------------------------------------------------------------------------------------------------------------

The sample submission of Faster-RCNN detector can be found in our website.

References

[1] T. Lin, M. Maire, S. J. Belongie, J. Hays, P. Perona, D. Ramanan, P. Dollar, and C. L. Zitnick, "Microsoft COCO: common objects in context", in ECCV 2014.

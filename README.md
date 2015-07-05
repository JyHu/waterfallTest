# waterfallTest



测试学习瀑布流的，使用UICollectionView做的。

根据[这个哥哥](http://www.cnblogs.com/xiaofeixiang/p/4430552.html)的帖子和demo学得。
Thank you .

##类的说明
* `MyCollectionViewLayout`这个类是我根据帖子写的。
* `AUUCollectionViewLayout`这个类是自己学习后封装的，实现了多列瀑布流，加上一些缓存的设置，在每次追加数据的时候减少了计算的过程。
* 必须要实现的`AUUCollectionViewLayoutDelegate`代理方法

|代理|说明|
|--
|collectionView:collectionViewLayout:sizeOfItemAtIndexPath|获取cell大小的代理|
|shouldCollectionViewRotationWhenDeviceOrientationWillChange:collectionViewLayout:device:|设备方向转换的时候提醒的代理方法|


##缺点
现在做到的只是一个section的瀑布流，对于多个section的，还没做好 -_-! 。对于当前写好的部分可能也有问题，后续在慢慢修改调试~


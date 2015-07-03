# waterfallTest



测试学习瀑布流的，使用UICollectionView做的。

根据[这个哥哥](http://www.cnblogs.com/xiaofeixiang/p/4430552.html)的帖子和demo学得。
Thank you .

##类的说明
* `MyCollectionViewLayout`这个类是我根据帖子写的。
* `AUUCollectionViewLayout`这个类是自己学习后封装的，实现了多列瀑布流，加上一些缓存的设置，在每次追加数据的时候减少了计算的过程。
* 使用的时候，只需要对`AUUCollectionViewLayoutDelegate`做一些简单的设置，并实现`collectionView:collectionViewLayout:sizeOfItemAtIndexPath`代理方法即可。

##缺点
现在做到的只是一个section的瀑布流，对于多个section的，还没做好 -_-! 。对于当前写好的部分可能也有问题，后续在慢慢修改调试~


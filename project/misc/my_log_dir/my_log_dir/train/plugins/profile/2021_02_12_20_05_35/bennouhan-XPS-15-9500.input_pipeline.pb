	'��>�I@'��>�I@!'��>�I@	Ջޤ��?Ջޤ��?!Ջޤ��?"w
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails6'��>�I@��	���?1z�W>E@A�e6�$�?I�a�1��@Y���/�1�?*	��x�&Y\@2l
5Iterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat�rK�!�?!��q��=@)O�����?1��3ǥ�7@:Preprocessing2F
Iterator::Model�@J�ڦ?!�����C@)e���m�?18��5>-4@:Preprocessing2U
Iterator::Model::ParallelMapV2��q�@H�?!��c�03@)��q�@H�?1��c�03@:Preprocessing2v
?Iterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate����?!�kN48@)-!�lV�?1#�I�D)@:Preprocessing2�
OIterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate[0]::TensorSlice$d �.ߊ?!��R|$'@)$d �.ߊ?1��R|$'@:Preprocessing2x
AIterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat::FromTensor��3�ތz?!a{����@)��3�ތz?1a{����@:Preprocessing2Z
#Iterator::Model::ParallelMapV2::Zipqx�ܙ�?!_	YQN@)<���ܴy?1I���#@:Preprocessing2f
/Iterator::Model::ParallelMapV2::Zip[0]::FlatMapC7�嶝?!8)}�4�9@)�I�%r�Y?1��Gg.�?:Preprocessing:�
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
�Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
�Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
�Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
�Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)�
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis�
both�Your program is POTENTIALLY input-bound because 3.1% of the total step time sampled is spent on 'All Others' time (which could be due to I/O or Python execution or both).moderate"�14.0 % of the total step time sampled is spent on 'Kernel Launch'. It could be due to CPU contention with tf.data. In this case, you may try to set the environment variable TF_GPU_THREAD_MODE=gpu_private.*no9Ջޤ��?I��S��31@Q�+�Y�T@Zno>Look at Section 3 for the breakdown of input time on the host.B�
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown�
	��	���?��	���?!��	���?      ��!       "	z�W>E@z�W>E@!z�W>E@*      ��!       2	�e6�$�?�e6�$�?!�e6�$�?:	�a�1��@�a�1��@!�a�1��@B      ��!       J	���/�1�?���/�1�?!���/�1�?R      ��!       Z	���/�1�?���/�1�?!���/�1�?b      ��!       JGPUYՋޤ��?b q��S��31@y�+�Y�T@
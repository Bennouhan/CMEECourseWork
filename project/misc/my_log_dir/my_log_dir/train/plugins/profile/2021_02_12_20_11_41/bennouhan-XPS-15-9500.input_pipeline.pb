	��oaݴL@��oaݴL@!��oaݴL@	DK5��۴?DK5��۴?!DK5��۴?"w
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails6��oaݴL@g_y��b�?1x}�O�D@Av�d�?I��Դ��,@Y"6X8I�?*	��/�<W@2l
5Iterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat�N��:7�?! ���ձ>@)<�l�ޕ?1Vb��v�6@:Preprocessing2U
Iterator::Model::ParallelMapV22˞6�?!���A�1@)2˞6�?1���A�1@:Preprocessing2F
Iterator::Modelg��F�?!��A@)8K�rJ�?1U$�o0@:Preprocessing2�
OIterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate[0]::TensorSliceܼqR���?!��vs$;*@)ܼqR���?1��vs$;*@:Preprocessing2v
?Iterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate|��S:�?!=��$Kt9@)�W}�?1�;�q�(@:Preprocessing2Z
#Iterator::Model::ParallelMapV2::Zip�Ac&Q�?!~;��}sP@)�1��l~?1�'H?�@:Preprocessing2x
AIterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat::FromTensor��Քd}?!���;{�@)��Քd}?1���;{�@:Preprocessing2f
/Iterator::Model::ParallelMapV2::Zip[0]::FlatMapf�"�ϙ?! Fa�[;@)��
��XY?11|����?:Preprocessing:�
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
�Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
�Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
�Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
�Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)�
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis�
device�Your program is NOT input-bound because only 0.1% of the total step time sampled is waiting for input. Therefore, you should focus on reducing other time.high"�25.0 % of the total step time sampled is spent on 'Kernel Launch'. It could be due to CPU contention with tf.data. In this case, you may try to set the environment variable TF_GPU_THREAD_MODE=gpu_private.*no9DK5��۴?I����Qf;@Qǽ]�4!R@Zno#You may skip the rest of this page.B�
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown�
	g_y��b�?g_y��b�?!g_y��b�?      ��!       "	x}�O�D@x}�O�D@!x}�O�D@*      ��!       2	v�d�?v�d�?!v�d�?:	��Դ��,@��Դ��,@!��Դ��,@B      ��!       J	"6X8I�?"6X8I�?!"6X8I�?R      ��!       Z	"6X8I�?"6X8I�?!"6X8I�?b      ��!       JGPUYDK5��۴?b q����Qf;@yǽ]�4!R@
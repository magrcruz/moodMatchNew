/*import 'package:huggingface_client/huggingface_client.dart';
//import '../api_key.dart';

/// Examples of how to use the Hugging Face Inference API to perform NLP
/// task based model queries.

void postData() async {
  // Get an inference client with your Hugging Face API key as authentication.
  final client = HuggingFaceClient.getInferenceClient(
      "", HuggingFaceClient.inferenceBasePath);

  // Get an instance of the inference API using our client
  final apiInstance = InferenceApi(client);

  //
  // Text Classification task
  //
  print('');
  print('*** Text Classification Task ***');
  print('');
  try {
    final input = 'I like you. I love you';
    final params = ApiQueryNLPTextClassification(inputs: [input]);
    final result = await apiInstance.queryNLPTextClassification(
        taskParameters: params,
        model: 'TFMUNIR/distilbert-base-uncased-finetuned-emotion-movies-186k');
    if (result!.isNotEmpty) {
      for (final row in result) {
        print(row);
      }
    } else {
      print('Inference task API Text Classification returned empty result');
    }
  } catch (e) {
    print(
        'Exception when calling Inference task API Text Classification: $e - exiting');
    return;
  }

  return;
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../logic/global_cubit.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Image.asset(
                    logoImage,
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<GlobalCubit, GlobalState>(
                        buildWhen: (previous, current) => previous.currentLang != current.currentLang,
                        builder: (context, state) => Text(
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium,
                            state.currentLang == 'en'
                                ? '''A Map_It news app based on localization, summarization, and classification is a powerful tool for delivering personalized and relevant news to individuals interested in global affairs.
                      
                      Localization refers to the ability of the app to identify a user's location and deliver news that is pertinent to their region or country. This ensures that users are always up-to-date with news that is relevant to their local commMap_Itty or country.
                      
                      Summarization is the process of condensing news articles into shorter, more digestible summaries. This is particularly useful for busy individuals who don't have the time or inclination to read full articles but still want to stay informed about global issues. The app can use natural language processing (NLP) techniques to automatically generate summaries of news articles related to the Map_Itted Nations and its member countries.
                      
                      Classification involves categorizing news articles into topics such as human rights, climate change, peace and security, development, and so on. This allows users to easily find news articles that are of interest to them and filter out those that are not.
                      
                      By combining localization, summarization, and classification, a Map_It news app can provide users with a highly personalized and relevant news experience. Users can receive news that is specific to their region or country, easily digestible, and tailored to their interests. This can lead to a more engaged and informed global commMap_Itty, which is beneficial for both the Map_Itted Nations and its users. Additionally, the app can provide a platform for member countries to share their own news or events, further fostering a sense of collaboration and cooperation on global issues.
                      '''
                                : '''تطبيق أخبار Map_Itلقائم على التمركز المحلي وتلخيص المحتوى والتصنيف هو أداة قوية لتقديم أخبار شخصية ومهمة للأفراد المهتمين بالشؤون العالمية.

يشير التمركز المحلي إلى قدرة التطبيق على تحديد موقع المستخدم وتقديم الأخبار المتعلقة بمنطقته أو بلده. وهذا يضمن أن يكون المستخدمون على اطلاع دائم بالأخبار التي تهم مجتمعهم المحلي أو بلدهم.

تلخيص المحتوى هو عملية ضغط المقالات الإخبارية إلى ملخصات أقصر وأكثر سهولة في الفهم. هذا مفيد بشكل خاص للأفراد الذين ليس لديهم الوقت أو الرغبة في قراءة المقالات بالكامل ولكنهم يريدون البقاء على اطلاع بالشؤون العالمية. يمكن للتطبيق استخدام تقنيات معالجة اللغة الطبيعية لتوليد ملخصات تلقائية للمقالات الإخبارية المتعلقة بالأمم المتحدة ودولها الأعضاء.

يتضمن التصنيف تصنيف المقالات الإخبارية في مواضيع مثل حقوق الإنسان وتغير المناخ والسلام والأمن والتنمية، وما إلى ذلك. يتيح هذا للمستخدمين العثور بسهولة على المقالات الإخبارية التي تهمهم وتصفية تلك التي لا تهمهم.

من خلال الجمع بين التمركز المحلي وتلخيص المحتوى والتصنيف، يمكن لتطبيق أخبار الأمم المتحدة توفير تجربة أخبار شخصية ومهمة للمستخدمين. يمكن للمستخدمين تلقي الأخبار التي تخص منطقتهم أو بلدهم، وتكون سهلة الفهم ومصممة حسب اهتماماتهم. ويمكن أن يؤدي ذلك إلى مجتمع عالمي أكثر انخراطًا وإدراكًا، مما يعود بالفائدة على الأمم المتحدة ومستخدميها. كما يمكن للتطبيق أن يوفر منصة لدول الأعضاء لمشاركة أخبارها أو أحداثها الخاصة، مما يعزز مزيدًا من الشعور بالتعاون والتعاون على القضايا العالمية.'''),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      );
}

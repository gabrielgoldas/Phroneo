import 'package:phroneo/features/onboarding/model/onboarding_page_model.dart';
import 'package:phroneo/i18n/strings.g.dart';

class OnboardingRepository {

  final List<OnboardingModel> _allOnboardingData = [
    OnboardingModel(title: t.onboardingPage.repo.objective.title,      description: t.onboardingPage.repo.objective.description       ),
    OnboardingModel(title: t.onboardingPage.repo.receiveNumber.title,  description: t.onboardingPage.repo.receiveNumber.description   ),
    OnboardingModel(title: t.onboardingPage.repo.thinkPhrase.title,    description: t.onboardingPage.repo.thinkPhrase.description     ),
    OnboardingModel(title: t.onboardingPage.repo.discoverOrder.title,  description: t.onboardingPage.repo.discoverOrder.description   ),
    OnboardingModel(title: t.onboardingPage.repo.reveal.title,         description: t.onboardingPage.repo.reveal.description          ),

  ];

  List<OnboardingModel> get allOnboardingData => _allOnboardingData;
}
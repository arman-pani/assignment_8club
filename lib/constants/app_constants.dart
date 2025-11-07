import 'package:assignment_8club/constants/app_images.dart';

enum Experience {
  party,
  dinner,
  brunch,
  picnic,
  lunch
} 

extension ExperienceExtension on Experience{
  String get selectedImage{
    switch(this){
      case Experience.party:
        return AppImages.stampPartySelected;
      case Experience.dinner:
        return AppImages.stampDinnerSelected;
      case Experience.brunch:
        return AppImages.stampBrunchSelected;
      case Experience.picnic: 
        return AppImages.stampPicnicSelected;
      case Experience.lunch:
        return AppImages.stampLunchSelected;
    }
  }

  String get unselectedImage{
    switch(this){
      case Experience.party:
        return AppImages.stampPartyUnselected;
      case Experience.dinner:
        return AppImages.stampDinnerUnselected;
      case Experience.brunch:
        return AppImages.stampBrunchUnselected;
      case Experience.picnic: 
        return AppImages.stampPicnicUnselected;
      case Experience.lunch:
        return AppImages.stampLunchUnselected;
    }
  }
}
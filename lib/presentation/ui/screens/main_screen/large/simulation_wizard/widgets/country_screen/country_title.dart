import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sj_manager/core/classes/country/country.dart';
import 'package:sj_manager/presentation/ui/reusable_widgets/countries/country_flag.dart';

class CountryTitle extends StatelessWidget {
  const CountryTitle({
    super.key,
    required this.country,
  });

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          country.name(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Gap(10),
        CountryFlag(
          country: country,
          width: 40,
        ),
      ],
    );
  }
}

part of '../training_analyzer_screen.dart';

class _Chart extends StatelessWidget {
  const _Chart({
    required this.result,
    required this.categories,
  });

  final TrainingAnalyzerResult result;
  final Set<TrainingAnalyzerDataCategory> categories;

  static const double seriesAnimationDurationInMs = 450;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: const Legend(
        isVisible: true,
        isResponsive: true,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        //shouldAlwaysShow: true,
        animationDuration: 300,
      ),
      primaryXAxis: NumericAxis(
        minimum: 0,
        plotBands: [
          for (final segment in result.segments.sublist(0, result.segments.length - 1))
            PlotBand(
              isVisible: true,
              start: segment.end,
              end: segment.end,
              borderWidth: 1,
              dashArray: const [2, 4],
              borderColor: Theme.of(context).colorScheme.onSurface,
            ),
        ],
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 20,
        rangePadding: ChartRangePadding.additional,
        decimalPlaces: 2,
      ),
      series: [
        if (categories.contains(TrainingAnalyzerDataCategory.takeoffQuality))
          LineSeries<TrainingAnalyzerDaySimulationResult, int>(
            animationDuration: seriesAnimationDurationInMs,
            name: 'Wybicie',
            dataSource: result.dayResults,
            xValueMapper: (result, _) => result.day,
            yValueMapper: (result, _) => result.trainingResult.takeoffDelta,
          ),
        if (categories.contains(TrainingAnalyzerDataCategory.flightQuality))
          LineSeries<TrainingAnalyzerDaySimulationResult, int>(
            animationDuration: seriesAnimationDurationInMs,
            name: 'Lot',
            dataSource: result.dayResults,
            xValueMapper: (result, _) => result.day,
            yValueMapper: (result, _) => result.trainingResult.flightDelta,
          ),
        if (categories.contains(TrainingAnalyzerDataCategory.landingQuality))
          LineSeries<TrainingAnalyzerDaySimulationResult, int>(
            animationDuration: seriesAnimationDurationInMs,
            name: 'Lądowanie',
            dataSource: result.dayResults,
            xValueMapper: (result, _) => result.day,
            yValueMapper: (result, _) => result.trainingResult.landingDelta,
          ),
        if (categories.contains(TrainingAnalyzerDataCategory.form))
          LineSeries<TrainingAnalyzerDaySimulationResult, int>(
            animationDuration: seriesAnimationDurationInMs,
            name: 'Forma',
            dataSource: result.dayResults,
            xValueMapper: (result, _) => result.day,
            yValueMapper: (result, _) => result.trainingResult.formDelta,
          ),
        if (categories.contains(TrainingAnalyzerDataCategory.jumpsConsistency))
          LineSeries<TrainingAnalyzerDaySimulationResult, int>(
            animationDuration: seriesAnimationDurationInMs,
            name: 'Równość',
            dataSource: result.dayResults,
            xValueMapper: (result, _) => result.day,
            yValueMapper: (result, _) => result.trainingResult.consistencyDelta,
          ),
        if (categories.contains(TrainingAnalyzerDataCategory.fatigue))
          LineSeries<TrainingAnalyzerDaySimulationResult, int>(
            animationDuration: seriesAnimationDurationInMs,
            name: 'Zmęczenie',
            dataSource: result.dayResults,
            xValueMapper: (result, _) => result.day,
            yValueMapper: (result, _) => result.trainingResult.fatigueDelta,
          ),
      ],
    );
  }
}

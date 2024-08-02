import 'package:flutter/material.dart';
import 'package:tempsensorapp/LineChart.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;
    double circleRadious = (MediaQuery.of(context).size.height / 5);
    final double toppadding = (orientation == Orientation.portrait
        ? circleRadious / 0.9
        : circleRadious / 5);

    return Container(
      decoration: BoxDecoration(
        gradient: baseContainerGradiant(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: toppadding),

          whiteCircleContainer(circleRadious),
          SizedBox(height: circleRadious / 10),

          Center(
            child: Text(
              "الحرارة الآن",
              style: TextStyle(
                fontSize: circleRadious / 7,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: circleRadious / 10),
          ButtonsRow(
            circleRadious: circleRadious,
            orientation: orientation,
          ),
          SyncFusionPlotter(circleRadious),

          // TempChartWidget(circleRadious: circleRadious),
          SizedBox(height: circleRadious / 4),
        ],
      ),
    );
  }

  Widget whiteCircleContainer(double circleWidth) {
    return Container(
      width: circleWidth,
      height: circleWidth,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "24°C",
          style: TextStyle(
            fontFamily: 'OpenSansBold',
            fontWeight: FontWeight.w900,
            fontSize: circleWidth / 3,
            color: const Color.fromARGB(255, 77, 82, 214),
          ),
        ),
      ),
    );
  }

  LinearGradient baseContainerGradiant() {
    return const LinearGradient(
      colors: [
        Color.fromARGB(255, 129, 138, 240),
        Color.fromARGB(255, 11, 43, 250)
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

class ButtonsRow extends StatelessWidget {
  final double circleRadious;
  final Orientation orientation;
  const ButtonsRow({
    required this.circleRadious,
    required this.orientation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      //buttons row
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          onPressed: () {},
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Text(
              'يوم',
              style: TextStyle(
                color: Colors.white,
                fontSize: orientation == Orientation.portrait
                    ? circleRadious / 9
                    : circleRadious / 6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0.0), // Set to 0.0 for square corners
            ),
          ),
          onPressed: () {},
          child: Text(
            'أسبوع',
            style: TextStyle(
                color: Colors.white,
                fontSize: orientation == Orientation.portrait
                    ? circleRadious / 9
                    : circleRadious / 6,
                fontWeight: FontWeight.w400),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[900],
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0.0), // Set to 0.0 for square corners
            ),
          ),
          onPressed: () {},
          child: Text(
            'شهر',
            style: TextStyle(
                color: Colors.white,
                fontSize: orientation == Orientation.portrait
                    ? circleRadious / 9
                    : circleRadious / 6,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamanda_admin/repository/daycare_appointment_repositorydb.dart';
import 'package:lamanda_admin/src/blocs/DaycareCubit/daycare_cubit.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class DayCareScreen extends StatefulWidget {
  @override
  _DayCareScreenState createState() => _DayCareScreenState();
}

class _DayCareScreenState extends State<DayCareScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DayCareCubit(DaycareAppointmentRepository())
        ..scheduleLoad(DateTime.now()),
      child: Scaffold(
          backgroundColor: ColorsApp.primaryColorBlue,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                  size: 25.0,
                ),
                onPressed: () => Navigator.of(context).pop()),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorsApp.primaryColorDark,
            title: Text(
              "Reservaciones para guarderia",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          body: Body()),
    );
  }
}

class Body extends StatefulWidget {
  Body() : super();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          buildTableCalendar(context),
          buildForm(),
        ],
      ),
    );
  }

  Widget buildTableCalendar(BuildContext context) {
    return BlocBuilder<DayCareCubit, DayCareState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return TableCalendar(
          daysOfWeekHeight: 40,
          locale: 'es_Es',
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.white),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              )),
          calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                  color: ColorsApp.primaryColorOrange, shape: BoxShape.circle),
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.white),
              disabledTextStyle: TextStyle(color: Colors.white70),
              isTodayHighlighted: false),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.orangeAccent),
          ),
          availableCalendarFormats: {CalendarFormat.week: 'Week'},
          firstDay: DateTime(2021, 1),
          lastDay: DateTime(3000, 12),
          focusedDay: state.date,
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) {
            return isSameDay(state.date, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(state.date, selectedDay)) {
              // Call `setState()` when updating the selected day

              context.read<DayCareCubit>().dateInCalendarChanged(selectedDay);
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            context.read<DayCareCubit>().dateInCalendarChanged(focusedDay);
          },
        );
      },
    );
  }

  Widget buildForm() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17), topRight: Radius.circular(17)),
            color: ColorsApp.backgroundColor),
        child: BlocBuilder<DayCareCubit, DayCareState>(
          builder: (context, state) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.dayCareAppoimentList.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed('detail',
                                  arguments: state.dayCareAppoimentList[index]);
                            },
                            title: Text(
                                state.dayCareAppoimentList[index].pet!.name!),
                            subtitle: Text(
                                '${state.dayCareAppoimentList[index].client!.userName}\n${DateFormat.jm().format(state.dayCareAppoimentList[index].entryHour!)} - ${DateFormat.jm().format(state.dayCareAppoimentList[index].departureHour!)}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(state
                                  .dayCareAppoimentList[index].pet!.photoUrl!),
                            ),
                            trailing: Icon(Icons.navigate_next)),
                        Divider(
                          height: 1.0,
                          color: Colors.grey,
                        )
                      ],
                    ));
          },
        ),
      ),
    );
  }
}

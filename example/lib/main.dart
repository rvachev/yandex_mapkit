import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:yandex_mapkit_example/examples/widgets/map_page.dart';
import 'package:yandex_mapkit_example/examples/circle_map_object_page.dart';
import 'package:yandex_mapkit_example/examples/clusterized_placemark_collection_page.dart';
import 'package:yandex_mapkit_example/examples/bicycle_page.dart';
import 'package:yandex_mapkit_example/examples/driving_page.dart';
import 'package:yandex_mapkit_example/examples/map_controls_page.dart';
import 'package:yandex_mapkit_example/examples/map_object_collection_page.dart';
import 'package:yandex_mapkit_example/examples/placemark_map_object_page.dart';
import 'package:yandex_mapkit_example/examples/polyline_map_object_page.dart';
import 'package:yandex_mapkit_example/examples/polygon_map_object_page.dart';
import 'package:yandex_mapkit_example/examples/reverse_search_page.dart';
import 'package:yandex_mapkit_example/examples/search_page.dart';
import 'package:yandex_mapkit_example/examples/suggest_page.dart';
import 'package:yandex_mapkit_example/examples/user_layer_page.dart';

void main() {
  runApp(MaterialApp(home: MainPage()));
}

const List<MapPage> _allPages = <MapPage>[
  MapControlsPage(),
  ClusterizedPlacemarkCollectionPage(),
  MapObjectCollectionPage(),
  PlacemarkMapObjectPage(),
  PolylineMapObjectPage(),
  PolygonMapObjectPage(),
  CircleMapObjectPage(),
  UserLayerPage(),
  SuggestionsPage(),
  SearchPage(),
  ReverseSearchPage(),
  BicyclePage(),
  DrivingPage(),
];

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _pushPage(BuildContext context, MapPage page) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (_) => Scaffold(
                appBar: AppBar(title: Text(page.title)),
                body:
                    Container(padding: const EdgeInsets.all(8), child: page))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('YandexMap examples'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.abc))
          ],
        ),
        body: YandexMap(
          tiles: [
            NetworkTileProvider(
              baseUrl:
                  'https://jet-pentest.gemsdev.ru/api/jet/v1/kazan/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=GeoWfExcavation&STYLE=&FORMAT=image/png&TILEMATRIXSET=3857&TILEMATRIX=3857:{z}&TILEROW={y}&TILECOL={x}',
              headers: {
                HttpHeaders.authorizationHeader:
                    'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc2MUNFQjVBN0U1RUZEOUVFQ0Q3ODc1NUI5RDkyOEMxRUJCRDE5QTNSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6ImRoenJXbjVlX1o3czE0ZFZ1ZGtvd2V1OUdhTSJ9.eyJuYmYiOjE2Nzk2MjgwNjYsImV4cCI6MTY3OTYzMTY2NiwiaXNzIjoiaHR0cHM6Ly9wZW50ZXN0LmdlbXNkZXYucnUiLCJjbGllbnRfaWQiOiJqZXRDbGllbnQiLCJzdWIiOiI5MjViMGIzYy1lNGY0LTQ5NDItYTVhMS0zYzc5NDA0YjE1YmEiLCJhdXRoX3RpbWUiOjE2Nzk2MjgwNjYsImlkcCI6ImxvY2FsIiwianRpIjoiMEMyMkNGRjU0RDQ3RkExN0EyMEUwOENFNDU3MzQxNkUiLCJpYXQiOjE2Nzk2MjgwNjYsInNjb3BlIjpbImpldGFwaSJdLCJhbXIiOlsicHdkIl19.GgX0RlQs83_UFafFiYQyM83rRDq_20JQJ3kC7vMaJXpuK6ROIia0SnP3VQj9D9ZDtpsGDrFLC95ZMend6U9jea7UQ5EdIniboH0GFgNGZ02nsUWfUKjqZCIo8MwUMk5gwBgU14ZwNhio1lHgvy0HpmOXaMxQBVVsQhXEOf4ZV4iRkBl2KXAwgELFZGq31YKUvm2Okefy4zse6nO6s4o2OBn7emzueFM83YLZ3hoL7yoeub_LoT6kHflKMvsDOyCOE7rviL6JP0zI4Pz7T6ogzcL7uumkV9gL3EEG3rYdcjCo8z62SQUEe11d7AEvOu0B3uKA-R6Po9DaZOeeBfezag'
              },
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function filterfunction;
  final Map filters;

  FiltersScreen({this.filterfunction, this.filters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  bool initDataloaded = false;

  @override
  Widget build(BuildContext context) {
    //putting this in initState would make the isloaded check unnecessary
    if(!initDataloaded){
      _glutenFree = widget.filters['glutenfree'];
      _vegetarian = widget.filters['vegetarian'];
      _vegan = widget.filters['vegan'];
      _lactoseFree = widget.filters['lactosefree'];
      initDataloaded = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal preferences')
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                      value: _glutenFree,
                      title: Text('Gluten-free'),
                      onChanged: (value) {
                        setState(() {
                          _glutenFree = value;
                        });
                      },
                  ),
                  SwitchListTile(
                    value: _vegetarian,
                    title: Text('Vegetarian'),
                    onChanged: (value) {
                      setState(() {
                        _vegetarian = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    value: _vegan,
                    title: Text('Vegan'),
                    onChanged: (value) {
                      setState(() {
                        _vegan = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    value: _lactoseFree,
                    title: Text('Lactose-free'),
                    onChanged: (value) {
                      setState(() {
                        _lactoseFree = value;
                      });
                    },
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.save),
                      iconSize: 48,
                      onPressed: () {
                        Map map = {
                          'glutenfree': _glutenFree,
                          'vegetarian': _vegetarian,
                          'vegan': _vegan,
                          'lactosefree': _lactoseFree
                        };
                        widget.filterfunction(map);
                      },
                      color: Colors.pink,
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(
		MaterialApp(
			initialRoute: '/',
			routes: {
				'/': (context) => const MyApp(),
				'/searchs': (context) => const PageAboutSearchResults(),
			},
		),
	);
}

class MyApp extends StatelessWidget{
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			/*appBar: AppBar(
				title: const Text('OMC++'),
			),*/
			//body: const MakeCard(),
			body: Center(
				child: Column(
					children: [
						SizedBox(
							height: 200,
						),
						Text(
							'OMC_Search',
							style: TextStyle(fontSize: 64),
						),
						SizedBox(
							height: 40,
						),
						MySearchBar(),
						//MySearchBar_legacy(),
					],
				),
			),
		);
	}
}

class MySearchBar extends StatelessWidget{
	const MySearchBar({super.key});

	@override
	Widget build(BuildContext context) {
		return  SizedBox(
			width: 720,
			height: 54,
			child: Card(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(40),
				),
				child: TextField(
					decoration: InputDecoration(
						prefixIcon: Icon(Icons.search),
						border: InputBorder.none,
					),
					onSubmitted: (_) {
						Navigator.of(context).pushNamed("/searchs");
					},
				),
			),
		);
	}
}

/*class MySearchBar_legacy extends StatelessWidget{
	const MySearchBar_legacy({super.key});
	
	@override
	Widget build(BuildContext context) {
		return SearchBar(
			backgroundColor: const MaterialStatePropertyAll<Color>(
				Colors.white),
			shadowColor: const MaterialStatePropertyAll<Color>(
				Colors.white),
			padding: const MaterialStatePropertyAll<EdgeInsets>(
				EdgeInsets.symmetric(horizontal: 16.0)),
			leading: const Icon(Icons.search),
		);
	}
}*/


/*class MakeCard extends StatelessWidget{
	const MakeCard({super.key});

	@override
	Widget build(BuildContext context) {
		return Card(
    	clipBehavior: Clip.hardEdge,
     	child: InkWell(
      	splashColor: Colors.blue.withAlpha(30),
       	onTap: () {
  	   		Navigator.pushNamed(context,'/solvers');
				},
    	  child: SizedBox(
					width: 300,
					height: 400,
					child: Column(
      	   	children: [
							SizedBox(
								width: 300,
								height: 100,
							),
            	Icon(
              		Icons.person,
               		color: Colors.blue,
               		size: 144.0,
 	            ),
      	     	Text(
        	   	   'About Solvers',
									style: TextStyle(
            	  	  fontSize: 32,
              		),
            	),
        		],
      		),
    		),
			),
		);
	}
}*/

class PageAboutSearchResults extends StatelessWidget {
	const PageAboutSearchResults({super.key});

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(
				title: const Text('Search Result:'),
			),
			body: Column(
				children: [
					ElevatedButton(
						onPressed: () {
							//navigate to the second screen when tapped.
							Navigator.pop(context);
						},
						child: Text('tentative'),
					),
					ListView.builder(
						padding: const EdgeInsets.all(8),
						itemCount: 4,
						itemBuilder: (BuildContext context, int index) {
							return Container(
								height: 50,
								child: Placeholder(),
							);
						},
					),
				],
			),
		);
	}
}





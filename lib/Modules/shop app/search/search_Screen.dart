import 'package:cv_training/Layout/shop%20app/cubit/cubit.dart';
import 'package:cv_training/Modules/shop%20app/search/searchCubit/cubit.dart';
import 'package:cv_training/Modules/shop%20app/search/searchCubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Searchcubit(SearchInitialState()),
      child: BlocConsumer<Searchcubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return 'Search Can\'t be Empty';
                          }
                          else
                            return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onTap: () {},
                        onChange: (value) {},
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            Searchcubit.get(context).getSearch(
                                searchController.text);
                          }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    if(state is SearchSucessState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildProductItems(Searchcubit
                                    .get(context)
                                    .searchModel
                                    .data!
                                    .data![index], context, inSearch: false),
                            separatorBuilder: (context, index) =>
                                myDivider(),
                            itemCount: Searchcubit
                                .get(context)
                                .searchModel
                                .data!
                                .data!
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

FlareActor flareLoading(){
  return FlareActor("assets/animations/loading_success_fail.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"loading");
}
%====================================================================================
% cargosystem description   
%====================================================================================
mqttBroker("192.168.0.226", "1883", "sprint1").
request( load_request, loadRequest(none) ).
reply( load_accepted, loadAccepted(SLOTID) ).  %%for load_request
reply( load_retrylater, loadRetryLater(none) ).  %%for load_request
reply( load_refused, loadRefused(none) ).  %%for load_request
request( container_detected, containerDetected(none) ).
reply( container_ack, containerAck(none) ).  %%for container_detected
request( robot_transfer, robotTransfer(SLOT) ).
reply( robot_complete, robotComplete(FINALSLOT) ).  %%for robot_transfer
request( find_free_slot, findFreeSlot(none) ).
reply( slot_found, slotFound(SLOTID) ).  %%for find_free_slot
reply( slot_full, slotFull(none) ).  %%for find_free_slot
request( find_occupy, occupySlot(SLOTID) ).
reply( occupy_done, occupySlotDone(none) ).  %%for find_occupy
request( find_release, releaseSlot(SLOTID) ).
reply( release_done, releaseSlotDone(none) ).  %%for find_release
dispatch( sensor_data, sensorData(DISTANCE) ).
dispatch( led_blink, ledBlink(STATE) ).
dispatch( display_update, displayUpdate(MESSAGE) ).
dispatch( robot_complete_notification, robotCompleteNotif(FINALSLOT) ).
dispatch( slot_is_free, slot_is_free(none) ).
dispatch( slot_is_full, slot_is_full(none) ).
dispatch( sonar_normal, sonar_normal(none) ).
dispatch( sonar_warn, sonar_warn(none) ).
dispatch( sonar_alert, sonar_alert(none) ).
request( moverobot, moverobot(TARGETX,TARGETY,STEPTIME) ).
reply( moverobotdone, moverobotdone(ARG) ).  %%for moverobot
reply( robot_failed, robotFailed(ARG) ).  %%for robot_transfer
reply( moverobotfailed, moverobotfailed(PLANDONE,PLANTODO) ).  %%for moverobot
request( tuneAtHome, tuneAtHome(X) ).
reply( tuneDone, tuneDone(X) ).  %%for tuneAtHome
dispatch( setrobotstate, setpos(X,Y,D) ).
%====================================================================================
context(ctxcargo, "localhost",  "TCP", "8050").
context(ctxrobotsmart, "127.0.0.1",  "TCP", "8020").
 qactor( robotsmart, ctxrobotsmart, "external").
  qactor( hold, ctxcargo, "it.unibo.hold.Hold").
 static(hold).
  qactor( cargoservice, ctxcargo, "it.unibo.cargoservice.Cargoservice").
 static(cargoservice).
  qactor( ioport, ctxcargo, "it.unibo.ioport.Ioport").
 static(ioport).
  qactor( cargorobot, ctxcargo, "it.unibo.cargorobot.Cargorobot").
 static(cargorobot).
  qactor( led, ctxcargo, "it.unibo.led.Led").
 static(led).
  qactor( markerdevice, ctxcargo, "it.unibo.markerdevice.Markerdevice").
 static(markerdevice).
  qactor( sonar, ctxcargo, "it.unibo.sonar.Sonar").
 static(sonar).

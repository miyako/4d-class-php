Class constructor($name : Text)
	
	This:C1470._name:=$name
	
	var __CLI__ : Object
	
Function get name()
	
	return This:C1470._name
	
Function expand($in : Object)->$out : Object
	
	$out:=OB Class:C1730($in).new($in.platformPath; fk platform path:K87:2)
	
Function quote($in : Text)->$out : Text
	
	$out:="\""+$in+"\""
	
Function start($function : 4D:C1709.Function)
	
	$signal:=New signal:C1641
	
	CALL WORKER:C1389(This:C1470.name; This:C1470._start; $function; $signal; Copy parameters:C1790(2))
	
	$signal.wait()
	
Function _start($function : 4D:C1709.Function; $signal : 4D:C1709.Signal; $params : Collection)
	
	var $CLI : cs:C1710._CLI
	
	$semaphore:=Current process name:C1392
	
	If (Not:C34(Test semaphore:C652($semaphore))) && (Not:C34(Semaphore:C143($semaphore)))
		
		$CLI:=$function.apply(Null:C1517; $params)
		
		__CLI__:=$CLI
		
	End if 
	
	$signal.trigger()
	
Function stop()
	
	$signal:=New signal:C1641
	
	CALL WORKER:C1389(This:C1470.name; This:C1470._stop; $signal)
	
	$signal.wait()
	
Function _stop($signal : 4D:C1709.Signal)
	
	var $CLI : cs:C1710._CLI
	
	$semaphore:=Current process name:C1392
	
	If (Test semaphore:C652($semaphore))
		
		$CLI:=__CLI__
		
		If ($CLI.controller.worker#Null:C1517)
			
			$CLI.controller.worker.terminate()
			
		End if 
		
		CLEAR SEMAPHORE:C144($semaphore)
		
	End if 
	
	$signal.trigger()
	
	KILL WORKER:C1390
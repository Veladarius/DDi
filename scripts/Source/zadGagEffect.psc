ScriptName zadGagEffect extends ActiveMagicEffect

; Libraries
zadLibs Property Libs Auto
SexLabFramework Property Sexlab Auto
import MfgConsoleFunc

actor Property Target Auto
Bool Property Terminate Auto

Function ClearMFG(actor ActorRef)
	ActorRef.ClearExpressionOverride()
	ResetPhonemeModifier(ActorRef)
EndFunction

Function DoRegister()
	if Terminate
		return
	EndIf
	RegisterForSingleUpdate(1.0)
EndFunction

Event OnUpdate()
	ApplyGagEffect()
	DoRegister()
EndEvent

Function ApplyGagEffect()
	if Terminate
		return
	EndIf
	if (!Target.Is3DLoaded() || Target.IsDead() || Target.IsDisabled())
		return
	EndIf
	Shout theShout = Target.GetEquippedShout()
	If theShout != None
		Target.UnequipShout(TheShout)
	EndIf
	libs.ApplyGagEffect(Target)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	libs.Log("OnEffectStart(gag)")
	target = akTarget
	Terminate = False
	ApplyGagEffect()
	DoRegister()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	libs.Log("OnEffectFinish(gag)")
	Terminate = true
	ClearMFG(target)
EndEvent

Event OnCellLoad()
	ApplyGagEffect()
	DoRegister()
EndEvent

Event OnCellAttach()
	OnCellLoad()
EndEvent

Event OnLoad()
	ApplyGagEffect()
	DoRegister()
EndEvent

Event OnUnload()
	; UnregisterForUpdate()
EndEvent


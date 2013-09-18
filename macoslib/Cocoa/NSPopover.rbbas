#tag Class
Class NSPopover
Inherits NSResponder
	#tag Method, Flags = &h0
		 Shared Function Available() As Boolean
		  return IsLion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  
		  #if TargetMacOS then
		    declare sub close lib CocoaLib selector "close" (obj_id as Ptr)
		    
		    close self
		  #else
		    #pragma Unused sender
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CocoaDelegateMap() As Dictionary
		  static d as new Dictionary
		  return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  #if targetMacOS
		    super.Constructor(Initialize(Allocate(Cocoa.NSClassFromString("NSPopover"))))
		    SetDelegate
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DelegateClassID() As Ptr
		  static p as Ptr = MakeDelegateClass
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function delegate_detachableWindowForPopover(id as Ptr, sel as Ptr, popover as Ptr) As Ptr
		  #pragma unused sel
		  
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey(id) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup(id, new WeakRef(nil))
		    dim obj as NSPopover = NSPopover(w.Value)
		    if obj <> nil then
		      dim nswnd as variant = obj.HandleDetachableWindowForPopover( new NSPopover(popover) )
		      if nswnd <> nil then
		        return nswnd
		      end if
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_popoverDidClose(id as Ptr, sel as Ptr, notification as Ptr)
		  #pragma unused sel
		  
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey(id) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup(id, new WeakRef(nil))
		    dim obj as NSPopover = NSPopover(w.Value)
		    if obj <> nil then
		      obj.HandlePopoverDidClose(new NSNotification(notification))
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_popoverDidShow(id as Ptr, sel as Ptr, notification as Ptr)
		  #pragma unused sel
		  
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey(id) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup(id, new WeakRef(nil))
		    dim obj as NSPopover = NSPopover(w.Value)
		    if obj <> nil then
		      obj.HandlePopoverDidShow(new NSNotification(notification))
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function delegate_popoverShouldClose(id as Ptr, sel as Ptr, popover as Ptr) As Boolean
		  #pragma unused sel
		  
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey(id) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup(id, new WeakRef(nil))
		    dim obj as NSPopover = NSPopover(w.Value)
		    if obj <> nil then
		      return obj.HandlePopoverShouldClose(new NSPopover(popover))
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_popoverWillClose(id as Ptr, sel as Ptr, notification as Ptr)
		  #pragma unused sel
		  
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey(id) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup(id, new WeakRef(nil))
		    dim obj as NSPopover = NSPopover(w.Value)
		    if obj <> nil then
		      obj.HandlePopoverWillClose(new NSNotification(notification))
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_popoverWillShow(id as Ptr, sel as Ptr, notification as Ptr)
		  #pragma unused sel
		  
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey(id) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup(id, new WeakRef(nil))
		    dim obj as NSPopover = NSPopover(w.Value)
		    if obj <> nil then
		      obj.HandlePopoverWillShow(new NSNotification(notification))
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FPtr(p as Ptr) As Ptr
		  //This function is a workaround for the inability to convert a Variant containing a delegate to Ptr:
		  //dim v as Variant = AddressOf Foo
		  //dim p as Ptr = v
		  //results in a TypeMismatchException
		  //So now I do
		  //dim v as Variant = FPtr(AddressOf Foo)
		  //dim p as Ptr = v
		  
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetDelegate() As Ptr
		  
		  #if TargetMacOS then
		    declare function delegate_ lib CocoaLib selector "delegate" (obj_id as Ptr) as Ptr
		    
		    return delegate_(self)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleDetachableWindowForPopover(popover as NSPopover) As NSWindow
		  return RaiseEvent DetachableWindowForPopover( popover )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandlePopoverDidClose(notification as NSNotification)
		  
		  RaiseEvent PopoverDidClose( notification )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandlePopoverDidShow(notification as NSNotification)
		  
		  RaiseEvent PopoverDidShow( notification )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandlePopoverShouldClose(popover as NSPopover) As Boolean
		  
		  return RaiseEvent PopoverShouldClose( popover )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandlePopoverWillClose(notification as NSNotification)
		  
		  RaiseEvent PopoverWillClose( notification )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandlePopoverWillShow(notification as NSNotification)
		  
		  RaiseEvent PopoverWillShow( notification )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MakeDelegateClass(className as String = DelegateClassName, superclassName as String = "NSObject") As Ptr
		  //this is Objective-C 2.0 code (available in Leopard).  For 1.0, we'd need to do it differently.
		  
		  #if TargetMacOS then
		    declare function objc_allocateClassPair lib CocoaLib (superclass as Ptr, name as CString, extraBytes as Integer) as Ptr
		    declare sub objc_registerClassPair lib CocoaLib (cls as Ptr)
		    declare function class_addMethod lib CocoaLib (cls as Ptr, name as Ptr, imp as Ptr, types as CString) as Boolean
		    
		    dim newClassId as Ptr = objc_allocateClassPair(Cocoa.NSClassFromString(superclassName), className, 0)
		    if newClassId = nil then
		      raise new macoslibException( "Unable to create ObjC subclass " + className + " from " + superclassName ) //perhaps the class already exists.  We could check for this, and raise an exception for other errors.
		      raise new ObjCException
		      return nil
		    end if
		    
		    'DReport  CurrentMethodName, "executing"
		    
		    objc_registerClassPair newClassId
		    
		    dim methodList() as Tuple
		    methodList.Append "detachableWindowForPopover:" : FPtr( AddressOf delegate_detachableWindowForPopover ) : "@@:@"
		    
		    methodList.Append "popoverShouldClose:" : FPtr( AddressOf delegate_popoverShouldClose ) : "B@:@"
		    
		    methodList.Append "popoverWillShow:"  : FPtr( AddressOf delegate_popoverWillShow )  : "v@:@"
		    methodList.Append "popoverWillClose:" : FPtr( AddressOf delegate_popoverWillClose ) : "v@:@"
		    
		    methodList.Append "popoverDidShow:"  : FPtr( AddressOf delegate_popoverDidShow )  : "v@:@"
		    methodList.Append "popoverDidClose:" : FPtr( AddressOf delegate_popoverDidClose ) : "v@:@"
		    
		    
		    dim methodsAdded as Boolean = true
		    for each item as Tuple in methodList
		      if NOT class_addMethod(newClassId, Cocoa.NSSelectorFromString(item(0)), item(1), item(2)) then
		        Raise new ObjCException
		      end if
		    next
		    
		    if methodsAdded then
		      return newClassId
		    else
		      dim e as new ObjCException
		      e.Message = CurrentMethodName + ". Couldn't create delegate"
		      raise  e
		      return nil
		    end if
		    
		  #else
		    #pragma unused className
		    #pragma unused superClassName
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PerformClose(sender as Ptr = Nil)
		  
		  #if TargetMacOS then
		    declare sub performClose lib CocoaLib selector "performClose:" (obj_id as Ptr, sender as Ptr)
		    
		    dim senderRef as Ptr
		    if sender <> Nil then
		      senderRef = sender
		    end if
		    
		    performClose self, senderRef
		  #else
		    #pragma Unused sender
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetDelegate()
		  
		  #if TargetMacOS then
		    declare function alloc lib CocoaLib selector "alloc" (class_id as Ptr) as Ptr
		    declare function init lib CocoaLib selector "init" (obj_id as Ptr) as Ptr
		    declare sub setDelegate lib CocoaLib selector "setDelegate:" (obj_id as Ptr, del_id as Ptr)
		    
		    
		    dim delegate_id as Ptr = init(alloc(DelegateClassID))
		    if delegate_id = nil then
		      return
		    end if
		    setDelegate self, delegate_id
		    CocoaDelegateMap.Value(delegate_id) = new WeakRef(self)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowRelativeToRect(positioningRect as Cocoa.NSRect, positioningView as NSView, preferredEdge as Cocoa.NSRectEdge)
		  
		  #if TargetMacOS then
		    declare sub showRelativeToRect lib CocoaLib selector "showRelativeToRect:ofView:preferredEdge:" (obj_id as Ptr, positioningRect as Cocoa.NSRect, positioningView as Ptr, preferredEdge as Cocoa.NSRectEdge)
		    
		    showRelativeToRect( self, positioningRect, positioningView, preferredEdge )
		  #else
		    #pragma Unused Rect
		    #pragma Unused View
		    #pragma Unused RectEdge
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DetachableWindowForPopover(popover as NSPopover) As NSWindow
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PopoverDidClose(notification as NSNotification)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PopoverDidShow(notification as NSNotification)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PopoverShouldClose(popover as NSPopover) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PopoverWillClose(notification as NSNotification)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PopoverWillShow(notification as NSNotification)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS then
			    declare function getAnimates lib CocoaLib selector "animates" (obj_id as Ptr) as Boolean
			    
			    return getAnimates( self )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS then
			    declare sub setAnimates lib CocoaLib selector "setAnimates:" (obj_id as Ptr, value as Boolean)
			    
			    setAnimates self, value
			  #else
			    #pragma Unused value
			  #endif
			End Set
		#tag EndSetter
		Animates As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS then
			    declare function getAppearance lib CocoaLib selector "appearance" (obj_id as Ptr) as NSPopoverAppearance
			    
			    return getAppearance( self )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS then
			    declare sub setAppearance lib CocoaLib selector "setAppearance:" (obj_id as Ptr, value as NSPopoverAppearance)
			    
			    setAppearance self, value
			  #else
			    #pragma Unused value
			  #endif
			End Set
		#tag EndSetter
		Appearance As NSPopoverAppearance
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS then
			    declare function getBehavior lib CocoaLib selector "behavior" (obj_id as Ptr) as NSPopoverBehavior
			    
			    return getBehavior( self )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS then
			    declare sub setBehavior lib CocoaLib selector "setBehavior:" (obj_id as Ptr, value as NSPopoverBehavior)
			    
			    setBehavior self, value
			  #else
			    #pragma Unused value
			  #endif
			End Set
		#tag EndSetter
		Behavior As NSPopoverBehavior
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS then
			    declare function getContentSize lib CocoaLib selector "contentSize" (obj_id as Ptr) as Cocoa.NSSize
			    
			    return getContentSize( self )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS then
			    declare sub setContentSize lib CocoaLib selector "setContentSize:" (obj_id as Ptr, value as Cocoa.NSSize)
			    
			    setContentSize self, value
			  #else
			    #pragma Unused value
			  #endif
			End Set
		#tag EndSetter
		ContentSize As Cocoa.NSSize
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS then
			    declare function getContentViewController lib CocoaLib selector "contentViewController" (obj_id as Ptr) as Ptr
			    
			    return New NSViewController( getContentViewController( self ) )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS then
			    declare sub setContentViewController lib CocoaLib selector "setContentViewController:" (obj_id as Ptr, value as Ptr)
			    
			    dim valueRef as Ptr
			    if value <> nil then
			      valueRef = value
			    end if
			    
			    setContentViewController self, valueRef
			  #else
			    #pragma Unused value
			  #endif
			End Set
		#tag EndSetter
		ContentViewController As NSViewController
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if TargetMacOS then
			    declare function getShown lib CocoaLib selector "isShown" (obj_id as Ptr) as Boolean
			    
			    return getShown( self )
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS then
			    declare sub setShown lib CocoaLib selector "setShown:" (obj_id as Ptr, value as Boolean)
			    
			    setShown self, value
			  #else
			    #pragma Unused value
			  #endif
			End Set
		#tag EndSetter
		Shown As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = DelegateClassName, Type = String, Dynamic = False, Default = \"macoslibNSPopover", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NSPopoverCloseReasonDetachToWindow, Type = String, Dynamic = False, Default = \"NSPopoverCloseReasonDetachToWindow", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NSPopoverCloseReasonKey, Type = String, Dynamic = False, Default = \"NSPopoverCloseReasonKey", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NSPopoverCloseReasonStandard, Type = String, Dynamic = False, Default = \"NSPopoverCloseReasonStandard", Scope = Public
	#tag EndConstant


	#tag Enum, Name = NSPopoverAppearance, Type = Integer, Flags = &h0
		Minimal
		HUD
	#tag EndEnum

	#tag Enum, Name = NSPopoverBehavior, Type = Integer, Flags = &h0
		ApplicationDefined
		  Transient
		Semitransient
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Animates"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="NSObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Shown"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

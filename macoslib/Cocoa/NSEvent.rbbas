#tag Class
Class NSEvent
Inherits NSObject
	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    declare function characters lib CocoaLib selector "characters" (obj_id as Ptr) as CFStringRef
			    
			    if Array(EventType.KeyDown, EventType.KeyUp).IndexOf(self.Type) > -1 then
			      return characters(self)
			    else
			      return ""
			    end if
			  #endif
			End Get
		#tag EndGetter
		Characters As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    declare function type lib CocoaLib selector "type" (obj_id as Ptr) as EventType
			    
			    return type(self)
			  #endif
			  
			  
			End Get
		#tag EndGetter
		Type As EventType
	#tag EndComputedProperty


	#tag Enum, Name = EventType, Type = Integer, Flags = &h0
		LeftMouseDown=1
		  LeftMouseUp=2
		  KeyDown=10
		KeyUp=11
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Characters"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
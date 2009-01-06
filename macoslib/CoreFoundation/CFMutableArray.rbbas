#tag Class
Class CFMutableArray
Inherits CFArray
	#tag Method, Flags = &h0
		Sub Value(index as Integer, Assigns theValue as CFType)
		  #if TargetMacOS
		    declare Sub CFArraySetValueAtIndex lib CarbonLib (theArray as Ptr, idx as Integer, theVal as Ptr)
		    
		    if index < 0 or index >= me.Count() then
		      raise new OutOfBoundsException
		    end if
		    
		    CFArraySetValueAtIndex me.Reference, index, theValue.Reference
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(capacity as Integer = 0)
		  // capacity=0 means unlimited capacity
		  
		  #if TargetMacOS
		    declare function CFArrayCreateMutable lib CarbonLib (allocator as Ptr, capacity as Integer, callbacks as Ptr) as Ptr
		    
		    super.Constructor CFArrayCreateMutable (nil, capacity, me.DefaultCallbacks), true
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Append(theItem as CFType)
		  #if TargetMacOS
		    declare Sub CFArrayAppendValue lib CarbonLib (theArray as Ptr, theValue as Ptr)
		    
		    CFArrayAppendValue me.Reference, theItem.Reference
		  #endif
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="CFArray"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="CFType"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

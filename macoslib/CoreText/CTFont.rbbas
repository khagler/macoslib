#tag Class
Class CTFont
Inherits CFType
	#tag Event
		Function ClassID() As CFTypeID
		  return CTFont.ClassID
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		 Shared Function ClassID() As CFTypeID
		  #if targetMacOS
		    declare function TypeID lib CarbonLib alias "CTFontGetTypeID" () as UInt32
		    static id as CFTypeID = CFTypeID(TypeID)
		    return id
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateWithName(name as String, size as Double = 0.0) As CTFont
		  'CTFontRef CTFontCreateWithName (
		  'CFStringRef name,
		  'CGFloat size,
		  'const CGAffineTransform *matrix
		  ');
		  
		  //According to the CTFont documentation, the default font size is currently 12.0.
		  
		  
		  #if targetMacOS
		    soft declare function CTFontCreateWithName lib CarbonLib (name as CFStringRef, size as Single, matrix as Ptr) as Ptr
		    
		    dim p as Ptr = CTFontCreateWithName(name, size, nil)
		    if p = nil then
		      return nil
		    end if
		    
		    return new CTFont(p, true)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportedLanguages() As String()
		  #if targetMacOS
		    soft declare function CTFontCopySupportedLanguages lib CarbonLib (font as Ptr) as Ptr
		    
		    dim p as Ptr = CTFontCopySupportedLanguages(me)
		    if p = nil then
		      dim emptylist(-1) as String
		      return emptylist
		    end if
		    
		    dim theList() as String
		    dim languageArray as new CFArray(p, true)
		    for i as Integer = 0 to languageArray.Count - 1
		      dim lang as CFString = CFString(languageArray.Value(i))
		      theList.Append lang
		    next
		    
		    return theList
		  #endif
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    soft declare function CTFontCopyFullName lib CarbonLib (font as Ptr) as CFStringRef
			    
			    return CTFontCopyFullName(me)
			  #endif
			End Get
		#tag EndGetter
		FullName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if targetMacOS
			    soft declare function CTFontGetSize lib CarbonLib (font as Ptr) as Single
			    
			    return CTFontGetSize(me)
			  #endif
			End Get
		#tag EndGetter
		Size As Double
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="CFType"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FullName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Size"
			Group="Behavior"
			Type="Double"
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

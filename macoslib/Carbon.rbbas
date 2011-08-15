#tag Module
Protected Module Carbon
	#tag Method, Flags = &h21
		Private Function GetSystemVersionFromCoreServices() As String
		  #if targetMacOS
		    const SystemVersionPListFile = "/System/Library/CoreServices/SystemVersion.plist"
		    const isDirectory = true
		    dim SystemVersionURL as CFURL = CFURL.CreateFromPOSIXPath(SystemVersionPListFile, not isDirectory)
		    if SystemVersionURL = nil then
		      return ""
		    end if
		    
		    soft declare function CFURLCreateDataAndPropertiesFromResource lib CarbonLib (alloc as Ptr, url as Ptr, ByRef resourceData as Ptr, properties as Ptr, desiredProperties as Ptr, ByRef errorCode as Int32) as Boolean
		    
		    dim errorCode as Int32
		    dim xmlDataPtr as Ptr
		    if CFURLCreateDataAndPropertiesFromResource(nil, SystemVersionURL, xmlDataPtr, nil, nil, errorCode) then
		      dim xmlData as new CFData(xmlDataPtr, CFType.hasOwnership)
		      dim errorMessageOut as String
		      dim pList as CFPropertyList = NewCFPropertyList(xmlData, kCFPropertyListImmutable, errorMessageOut)
		      try
		        dim d as CFDictionary = CFDictionary(pList)
		        const ProductVersionKey = "ProductVersion"
		        dim ProductVersionValue as CFString = CFString(d.Value(new CFString(ProductVersionKey)))
		        return ProductVersionValue.StringValue
		        
		        
		      catch e as IllegalCastException
		        //file format was changed....
		        return ""
		      end try
		    else
		      return ""
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSystemVersionFromGestalt() As String
		  dim sys1, sys2, sys3 as Integer
		  call System.Gestalt("sys1", sys1)
		  call System.Gestalt("sys2", sys2)
		  call System.Gestalt("sys3", sys3)
		  if sys1 <> 0 then
		    return Format(sys1,"#")+"."+Format(sys2,"#")+"."+Format(sys3,"#")
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLeopard() As Boolean
		  // Tells you if this OS has features of this version
		  // This means that it returns true for later OS versions as well.
		  // If you want to test for a particular version, use SystemVersionAsInt
		  
		  return SystemVersionAsInt >= 100500
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLion() As Boolean
		  // Tells you if this OS has features of this version
		  // This means that it returns true for later OS versions as well.
		  // If you want to test for a particular version, use SystemVersionAsInt
		  
		  return SystemVersionAsInt >= 100700
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPanther() As Boolean
		  // Tells you if this OS has features of this version
		  // This means that it returns true for later OS versions as well.
		  // If you want to test for a particular version, use SystemVersionAsInt
		  
		  return SystemVersionAsInt >= 100300
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSlowLeopard() As Boolean
		  // Tells you if this OS has features of this version
		  // This means that it returns true for later OS versions as well.
		  // If you want to test for a particular version, use SystemVersionAsInt
		  
		  return SystemVersionAsInt >= 100600
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTiger() As Boolean
		  // Tells you if this OS has features of this version
		  // This means that it returns true for later OS versions as well.
		  // If you want to test for a particular version, use SystemVersionAsInt
		  
		  return SystemVersionAsInt >= 100400
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Languages() As String()
		  dim languagelist as CFArray = CFArray(CFPreferences.Value("AppleLanguages"))
		  
		  dim theList() as String
		  for i as Integer = 0 to languagelist.Count - 1
		    theList.Append CFString(languagelist.Value(i))
		  next
		  
		  return theList
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowAboutBox(name as String = "", version as String = "", copyright as String = "", description as String = "")
		  dim d as new CFMutableDictionary
		  
		  if name <> "" then
		    d.Value(CFString("HIAboutBoxName")) = CFString(name)
		  end if
		  if version <> "" then
		    d.Value(CFString("HIAboutBoxVersion")) = CFString(version)
		  end if
		  if copyright <> "" then
		    d.Value(CFString("HIAboutBoxCopyright")) = CFString(copyright)
		  end if
		  if description <> "" then
		    d.Value(CFString("HIAboutBoxDescription")) = CFString(description)
		  end if
		  
		  #if targetMacOS
		    soft declare function HIAboutBox lib CarbonLib (inOptions as Ptr) as Integer
		    
		    dim OSError as Integer = HIAboutBox(d)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpotlightSearch(searchTerm as String)
		  //opens a Spotlight search window and does the search using searchTerm
		  //if searchTerm = "", a search window is opened
		  
		  #if targetMacOS
		    soft declare function HISearchWindowShow lib "Carbon.framework" (inSearchString as CFStringRef, inOptions as UInt32) as Integer
		    
		    const kNilOptions = 0
		    dim OSError as Integer = HISearchWindowShow(searchTerm, kNilOptions)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SystemUIMode() As UIMode
		  #if targetMacOS
		    soft declare sub GetSystemUIMode lib CarbonLib (ByRef mode as UIMode, outOptions as Ptr)
		    
		    dim mode as UIMode
		    GetSystemUIMode mode, nil
		    return mode
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SystemUIMode(mode as UIMode, options as UIOptions)
		  #if targetMacOS
		    soft declare function SetSystemUIMode lib CarbonLib (inMode as UIMode, inOptions as UIOptions) as Integer
		    
		    dim OSError as Integer = SetSystemUIMode(mode, options)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SystemUIOptions() As UIOptions
		  #if targetMacOS
		    soft declare sub GetSystemUIMode lib CarbonLib (mode as Ptr, ByRef outOptions as UIOptions)
		    
		    dim options as UIOptions
		    GetSystemUIMode nil, options
		    return options
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SystemVersionAsInt() As Integer
		  // The value returned is scaled up, so that a version like 10.1.2 becomes 100102, i.e. two digits per part.
		  //
		  // This function avoids using floating point, so that a version such as 10.4 doesn't become 10.39999 or something alike, making a test for >=10.4 fail
		  
		  static version as Integer
		  
		  if version = 0 then
		    dim parts() as String = SystemVersionAsString.Split(".")
		    version = 10000 * parts(0).Val + 100 * parts(1).Val
		    if parts.Ubound >= 2 then
		      version = version + parts(2).Val
		    end
		  end
		  
		  return version
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SystemVersionAsString() As String
		  // This returns the OS X system version as a String. Use this to display the
		  // system version.
		  //
		  // Careful!
		  //   Do not use the returned value to test for particular system versions!
		  //   Use SystemVersionAsInt for comparisons instead!
		  //
		  // If you do not obey this rule you will get wrong results if you test for
		  //   SystemVersionAsString >= "10.6"
		  // with the actual OS X version being 10.11: Then the string "10.6" will be
		  // greater than "10.11", which is the wrong result for your test.
		  
		  static version as String = GetSystemVersionFromCoreServices
		  if version = "" then
		    version = GetSystemVersionFromGestalt
		  end if
		  return version
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _testAssert(b as Boolean, msg as String = "")
		  #if DebugBuild
		    if not b then
		      break
		      #if TargetHasGUI
		        MsgBox "Test in Carbon module failed: "+EndOfLine+EndOfLine+msg
		      #else
		        Print "Test in Carbon module failed: "+msg
		      #endif
		    end
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub _TestSelf()
		  _testAssert GetSystemVersionFromCoreServices = GetSystemVersionFromGestalt // this test might fail with x.y.0 versions - should fix either function accordingly then
		  select case GetSystemVersionFromGestalt.Left(4)
		  case "10.3"
		    _testAssert IsPanther
		    _testAssert not IsTiger
		  case "10.4"
		    _testAssert IsPanther
		    _testAssert IsTiger
		    _testAssert not IsLeopard
		  case "10.5"
		    _testAssert IsTiger
		    _testAssert IsLeopard
		    _testAssert not IsSlowLeopard
		  case "10.6"
		    _testAssert IsLeopard
		    _testAssert IsSlowLeopard
		    _testAssert not IsLion
		  else
		    _testAssert IsSlowLeopard
		    _testAssert IsLion
		  end select
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This is part of the open source "MacOSLib"
		
		Original sources are located here:  http://code.google.com/p/macoslib
	#tag EndNote


	#tag Constant, Name = activeFlagBit, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = alphaLockBit, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = btnStateBit, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CarbonLib, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"Carbon.framework"
	#tag EndConstant

	#tag Constant, Name = cmdKeyBit, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = controlKeyBit, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kInvalidID, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNilOptions, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kUnknownType, Type = String, Dynamic = False, Default = \"\?\?\?\?", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kVariableLengthArray, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = noErr, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = optionKeyBit, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = rightControlKeyBit, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = rightOptionKeyBit, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = rightShiftKeyBit, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = shiftKeyBit, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant


	#tag Structure, Name = LongDateRec, Flags = &h0
		era as Int16
		  year as Int16
		  month as Int16
		  day as Int16
		  hour as Int16
		  minute as Int16
		  second as Int16
		  dayOfWeek as Int16
		  dayOfYear as Int16
		  weekOfYear as Int16
		  pm as Int16
		  res1 as Int16
		  res2 as Int16
		res3 as Int16
	#tag EndStructure

	#tag Structure, Name = MacPoint, Flags = &h0
		v as Int16
		h as Int16
	#tag EndStructure

	#tag Structure, Name = MacRect, Flags = &h0
		top as Int16
		  left as Int16
		  bottom as Int16
		right as Int16
	#tag EndStructure

	#tag Structure, Name = Str255, Flags = &h0
		length as Uint8
		data as String*255
	#tag EndStructure

	#tag Structure, Name = UTCDateTime, Flags = &h0
		highSeconds as UInt16
		  lowSeconds as UInt32
		fraction as UInt16
	#tag EndStructure


	#tag Enum, Name = UIMode, Flags = &h0
		Normal = 0
		  ContentSuppressed = 1
		  ContentHidden = 2
		  AllSuppressed = 4
		AllHidden = 3
	#tag EndEnum

	#tag Enum, Name = UIOptions, Flags = &h0
		AutoShowMenuBar = 1
		  DisableAppleMenu = 4
		  DisableProcessSwitch = 8
		  DisableForceQuit = 16
		  DisableSessionTerminate = 32
		DisableHide = 64
	#tag EndEnum


	#tag ViewBehavior
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
End Module
#tag EndModule

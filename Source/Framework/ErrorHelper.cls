VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ErrorHelper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'The MIT License (MIT)
'Copyright (c) 2012 Kelly Ethridge
'
'Permission is hereby granted, free of charge, to any person obtaining a copy
'of this software and associated documentation files (the "Software"), to deal
'in the Software without restriction, including without limitation the rights to
'use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
'the Software, and to permit persons to whom the Software is furnished to do so,
'subject to the following conditions:
'
'The above copyright notice and this permission notice shall be included in all
'copies or substantial portions of the Software.
'
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
'INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
'PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
'FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
'OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
'DEALINGS IN THE SOFTWARE.
'
'
' Module: ErrorHelper
'
Option Explicit

Private Const SOURCE_OBJECT                     As String = "SourceObject"
Private Const SOURCE_METHOD                     As String = "SourceMethod"
Private Const ARG_NAME                          As String = "ArgName"
Private Const METHOD_CANNOTBENOTHING            As String = "CannotBeNothing"
Private Const METHOD_CANNOTBEEMPTY              As String = "CannotBeEmpty"
Private Const METHOD_CANNOTBENEGATIVE           As String = "CannotBeNegative"
Private Const METHOD_INDEXOUTOFRANGE            As String = "IndexOutOfRange"
Private Const METHOD_ENUMERATIONNOTSUPPORTED    As String = "EnumerationNotSupported"
Private Const METHOD_ARGUMENT                   As String = "Argument"



Public Sub Argument(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String, ByRef Description As String)
    ValidateParameters SourceObject, SourceMethod, ArgName, METHOD_ARGUMENT
    
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)
    
    Err.Raise ErrorCode.Argument, Source, "Invalid argument '" & ArgName & "'. " & Description
End Sub

Friend Sub ResourceArgument(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String, ByVal ID As StringResourceID)
    ValidateParameters SourceObject, SourceMethod, ArgName, METHOD_ARGUMENT
    
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)
    
    Err.Raise ErrorCode.Argument, Source, "Invalid argument '" & ArgName & "'. " & Resource.GetString(ID, ArgName)
End Sub

Public Sub CannotBeNothing(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String)
    ValidateParameters SourceObject, SourceMethod, ArgName, METHOD_CANNOTBENOTHING
    
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)

    Dim Description As String
    Description = Resource.GetString(Arg_CannotBeNothing, ArgName)

    Err.Raise ErrorCode.ArgumentNull, Source, Description
End Sub

Public Sub CannotBeEmpty(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String)
    ValidateParameters SourceObject, SourceMethod, ArgName, METHOD_CANNOTBEEMPTY
        
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)
    
    Dim Description As String
    Description = Resource.GetString(Arg_CannotBeEmpty, ArgName)
    
    Err.Raise ErrorCode.Argument, Source, Description
End Sub

Public Sub CannotBeNegative(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String)
    ValidateParameters SourceObject, SourceMethod, ArgName, METHOD_CANNOTBENEGATIVE
    
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)
    
    Dim Description As String
    Description = Resource.GetString(Arg_CannotBeNegative, ArgName)
    
    Err.Raise ErrorCode.ArgumentOutOfRange, Source, Description
End Sub

Public Sub IndexOutOfRange(ByVal SourceObject As Object, ByRef SourceMethod As String)
    ValidateParameters SourceObject, SourceMethod, "Index", METHOD_INDEXOUTOFRANGE
    
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)
    
    Dim Description As String
    Description = Resource.GetString(Arg_IndexOutOfRange)
    
    Err.Raise ErrorCode.IndexOutOfRange, Source, Description
End Sub

Public Sub EnumerationNotSupported(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String)
    ValidateParameters SourceObject, SourceMethod, ArgName, METHOD_ENUMERATIONNOTSUPPORTED
    
    Dim Source As String
    Source = BuildSource(SourceObject, SourceMethod)
    
    Dim Description As String
    Description = Resource.GetString(Arg_EnumerationNonSupported)
    
    Err.Raise ErrorCode.Argument, Source, Description
End Sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Private Helpers
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub ValidateParameters(ByVal SourceObject As Object, ByRef SourceMethod As String, ByRef ArgName As String, ByRef ErrorHelperMethod As String)
    If SourceObject Is Nothing Then
        CannotBeNothing Me, ErrorHelperMethod, SOURCE_OBJECT
    End If
    If Len(SourceMethod) = 0 Then
        CannotBeEmpty Me, ErrorHelperMethod, SOURCE_METHOD
    End If
    If Len(ArgName) = 0 Then
        CannotBeEmpty Me, ErrorHelperMethod, ARG_NAME
    End If
End Sub

Private Function BuildSource(ByVal SourceObject As Object, ByRef SourceMethod As String) As String
    BuildSource = TypeName(SourceObject) & "." & SourceMethod
End Function


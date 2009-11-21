VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "TestOutput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' Copyright 2009 Kelly Ethridge
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.
'
' Module: TestOutput
'
Option Explicit

Public Enum TestOutputType
    StandardOutput
    ErrorOutput
    TraceOutput
    LogOutput
End Enum

Private mText       As String
Private mOutputType As TestOutputType


Public Property Get Text() As String
    Text = mText
End Property

Public Property Get OutputType() As TestOutputType
    OutputType = mOutputType
End Property

Friend Sub Init(ByVal Text As String, ByVal OutputType As TestOutputType)
    mText = Text
    mOutputType = OutputType
End Sub
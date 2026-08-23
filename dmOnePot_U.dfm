object dmOnePot: TdmOnePot
  OldCreateOrder = False
  Height = 421
  Width = 696
  object conOnePot: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\sohai\Docu' +
      'ments\GitHub\Project-One-Pot\Database\OnePot.mdb;Persist Securit' +
      'y Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 104
  end
  object tblCustomers: TADOTable
    Active = True
    Connection = conOnePot
    CursorType = ctStatic
    TableName = 'tblCustomers'
    Left = 200
    Top = 64
  end
  object dscCustomers: TDataSource
    DataSet = tblCustomers
    Left = 296
    Top = 64
  end
  object tblEmployees: TADOTable
    Active = True
    Connection = conOnePot
    CursorType = ctStatic
    TableName = 'tblEmployees'
    Left = 200
    Top = 136
  end
  object dscEmployees: TDataSource
    Left = 296
    Top = 137
  end
end

object dmOnePot: TdmOnePot
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 421
  Width = 696
  object conOnePot: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=OnePot.mdb;Mode=Rea' +
      'dWrite;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmReadWrite
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
    DataSet = tblEmployees
    Left = 296
    Top = 137
  end
  object tblStock: TADOTable
    Active = True
    Connection = conOnePot
    CursorType = ctStatic
    TableName = 'tblStock'
    Left = 200
    Top = 208
  end
  object dscStock: TDataSource
    DataSet = tblStock
    Left = 296
    Top = 208
  end
  object tblMenu: TADOTable
    Active = True
    Connection = conOnePot
    CursorType = ctStatic
    TableName = 'tblMenu'
    Left = 200
    Top = 280
  end
  object dscMenu: TDataSource
    DataSet = tblMenu
    Left = 296
    Top = 280
  end
  object tblRecipe: TADOTable
    Active = True
    Connection = conOnePot
    CursorType = ctStatic
    TableName = 'tblRecipe'
    Left = 200
    Top = 344
  end
  object dscRecipe: TDataSource
    DataSet = tblRecipe
    Left = 296
    Top = 344
  end
  object tblReservations: TADOTable
    Active = True
    Connection = conOnePot
    CursorType = ctStatic
    TableName = 'tblReservations'
    Left = 456
    Top = 256
  end
  object dscReservations: TDataSource
    DataSet = tblReservations
    Left = 536
    Top = 256
  end
end

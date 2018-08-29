module VktDriver
  alias Vkt7ElementType = Vkt7MeasureElementType | Vkt7FractionElementType | Vkt7DataElementType

  # Element measure type
  enum Vkt7MeasureElementType
    # Measure type for temperature
    TTypeM = 44,
    # Measure type for volume flow
    GTypeM = 45,
    # Measure type for volume
    VTypeM = 46,
    # Measure type for mass
    MTypeM = 47,
    # Measure type for pressure
    PTypeM = 48,
    # Measure type for temperature difference
    DtTypeM = 49,
    # Measure type for temperature of cold water
    TswTypeM = 50,
    # Measure type for temperature of air
    TaTypeM = 51,
    # Measure type for mass taken from system
    MgTypeM = 52,
    # Measure type for heat energy total
    QoTypeM = 53,
    # Measure type for heat energy in pipe 3
    QgTypeM = 54,
    # Measure type for time on normal working
    QntTypeHIM = 55,
    # Measure type for time of calculation absent
    QntTypeM = 56
  end

  # Element fraction type
  enum Vkt7FractionElementType
    # Faction for temperature of heat system 1
    TTypeFractDiNum = 57,
    # Faction for volume flow of heat system 1
    GTypeFractDigNum1 = 58,
    # Faction for volume of heat system 1
    VTypeFractDigNum1 = 59,
    # Faction for mass of heat system 1
    MTypeFractDigNum1 = 60,
    # Faction for pressure of heat system 1
    PTypeFractDigNum1 = 61,
    # Faction for temperatore difference of heat system 1
    DtTypeFractDigNum1 = 62,
    # Faction for cold water temperature of heat system 1
    TswTypeFractDigNum1 = 63,
    # Faction for air temperature of heat system 1
    TaTypeFractDigNum1 = 64,
    # Faction for mass taken from system of heat system 1
    MgTypeFractDigNum1 = 65,
    # Faction for heat energy of heat system 1
    QoTypeFractDigNum1 = 66,
    # Faction for temperature of heat system 2
    TTypeFractDigNum2 = 67,
    # Faction for volume flow of heat system 2
    GTypeFractDigNum2 = 68,
    # Faction for volume of heat system 2
    VTypeFractDigNum2 = 69,
    # Faction for mass of heat system 2
    MTypeFractDigNum2 = 70,
    # Faction for pressure of heat system 2
    PTypeFractDigNum2 = 71,
    # Faction for temperatore difference of heat system 2
    DtTypeFractDigNum2 = 72,
    # Faction for cold water temperature of heat system 2
    TswTypeFractDigNum2 = 73,
    # Faction for air temperature of heat system 2
    TaTypeFractDigNum2 = 74,
    # Faction for mass taken from system of heat system 2
    MgTypeFractDigNum2 = 75,
    # Faction for heat energy of heat system 2
    QoTypeFractDigNum2 = 76
  end

  # Data element type
  enum Vkt7DataElementType
    # Temperature value in Pipe 1 of heat system 1
    T1_1Type = 0,
    # Temperature value in Pipe 2 of heat system 1
    T2_1Type = 1,
    # Temperature value in Pipe 3 of heat system 1
    T3_1Type = 2,
    # Volume value in Pipe 1 of heat system 1
    V1_1Type = 3,
    # Volume value in Pipe 2 of heat system 1
    V2_1Type = 4,
    # Volume value in Pipe 3 of heat system 1
    V3_1Type = 5,
    # Mass value in Pipe 1 of heat system 1
    M1_1Type = 6,
    # Mass value in Pipe 2 of heat system 1
    M2_1Type = 7,
    # Mass value in Pipe 3 of heat system 1
    M3_1Type = 8,
    # Pressure value in Pipe 1 of heat system 1
    P1_1Type = 9,
    # Pressure value in Pipe 2 of heat system 1
    P2_1Type = 10,
    # Mass of water taken from heat system 1
    Mg_1TypeP = 11,
    # Heat energy total of heat system 1
    Qo_1TypeP = 12,
    # Heat energy in pipe 3 of heat system 1
    Qg_1TypeP = 13,
    # Temperature difference of heat system 1
    Dt_1TypeP = 14,
    # Temperature of cold water of heat system 1
    TswTypeP = 15,
    # Temperature of air of heat system 1
    TaTypeP = 16,
    # Time of normal working of heat system 1
    QntType_1HIP = 17,
    # Time of calculation absent of heat system 1
    QntType_1P = 18,
    # Volume flow value in Pipe 1 of heat system 1
    G1Type = 19,
    # Volume flow value in Pipe 2 of heat system 1
    G2Type = 20,
    # Volume flow value in Pipe 3 of heat system 1
    G3Type = 21,

    # Temperature value in Pipe 1 of heat system 2
    T1_2Type = 22,
    # Temperature value in Pipe 2 of heat system 2
    T2_2Type = 23,
    # Temperature value in Pipe 3 of heat system 2
    T3_2Type = 24,
    # Volume value in Pipe 1 of heat system 2
    V1_2Type = 25,
    # Volume value in Pipe 2 of heat system 2
    V2_2Type = 26,
    # Volume value in Pipe 3 of heat system 2
    V3_2Type = 27,
    # Mass value in Pipe 1 of heat system 2
    M1_2Type = 28,
    # Mass value in Pipe 2 of heat system 2
    M2_2Type = 29,
    # Mass value in Pipe 3 of heat system 2
    M3_2Type = 30,
    # Pressure value in Pipe 1 of heat system 2
    P1_2Type = 31,
    # Pressure value in Pipe 2 of heat system 2
    P2_2Type = 32,
    # Mass of water taken from heat system 2
    Mg_2TypeP = 33,
    # Heat energy total of heat system 2
    Qo_2TypeP = 34,
    # Temperature difference of heat system 2
    Qg_2TypeP = 35,
    # Temperature difference of heat system 2
    Dt_2TypeP = 36,
    # Reserve
    Tsw_2TypeP = 37,
    # Reserve
    Ta_2TypeP = 38,
    # Time of normal working of heat system 2
    Qnt_2TypeHIP = 39,
    # Time of calculation absent of heat system 2
    Qnt_2TypeP = 40,
    # Volume flow value in Pipe 1 of heat system 2
    G1_2Type = 41,
    # Volume flow value in Pipe 2 of heat system 2
    G2_2Type = 42,
    # Volume flow value in Pipe 3 of heat system 2
    G3_2Type = 43

    # Emergency situation of heat system 1
    NSPrintTypeM_1 = 77,
    # Emergency situation of heat system 2
    NSPrintTypeM_2 = 78,
    # Emergency situation duration of heat system 1
    QntNS_1 = 79,
    # Emergency situation duration of heat system 2
    QntNS_2 = 80,
    # Additional input
    DopInpImpP_Type = 81,
    # Pressure pipe 3
    P3P_Type = 82
  end
end

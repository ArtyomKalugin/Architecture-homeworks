//
//  MacroCommands.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

final class MacroCommands {
    
    func register() {
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: .zero,
            directionsNumber: .zero,
            angularVelocity: .zero,
            fuel: .zero,
            fuelConsumptionVelocity: .zero
        )
        // Команда движения по прямой с расходом топлива,
        let moveDirectlyCommand = MacroCommand(
            commands: [
                CheckFuelCommand(fuelableObject: universalObject),
                MoveCommand(movingObject: universalObject),
                BurnFuelCommand(fuelableObject: universalObject)
            ]
        )
        
        // Команда поворота, которая еще и меняет вектор мгновенной скорости, если есть
        let rotateAndMoveDirectlyCommand = MacroCommand(
            commands: [
                CheckFuelCommand(fuelableObject: universalObject),
                ChangeVelocityCommand(rotatableObject: universalObject),
                MoveCommand(movingObject: universalObject),
                BurnFuelCommand(fuelableObject: universalObject)
            ]
        )
    }
}

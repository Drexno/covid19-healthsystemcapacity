import React from 'react';
import { getBreaksStyle, formatNumber } from '../utils/healthcareMapStyling';

export default function Legend({ classBreaks, indicator, aggType, perCapita }) {
    if (!classBreaks) return null;
    const { colors, breaksValues } = getBreaksStyle(
        classBreaks,
        indicator,
        aggType,
        perCapita,
    );
    const legendSteps = colors.map((color, i) => {
        const from = formatNumber(breaksValues[i], indicator);
        const to = formatNumber(breaksValues[i + 1], indicator);
        return (
            <React.Fragment key={`break-${i}`}>
                <div
                    className="legend-color"
                    style={{ backgroundColor: color }}
                ></div>

                <div className="legend-numbers">
                    {from}–{to}
                </div>
            </React.Fragment>
        );
    });
    return (
        <div className="legend-container">
            <div id="legend">{legendSteps}</div>
        </div>
    );
}
